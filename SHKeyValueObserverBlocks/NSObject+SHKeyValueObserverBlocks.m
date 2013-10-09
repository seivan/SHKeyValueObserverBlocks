//
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "NSObject+SHKeyValueObserverBlocks.h"
#import <objc/runtime.h>


@interface SHKeyValueObserverBlocksManager : NSObject
@property(nonatomic,assign) BOOL           isAutoCleaning;
@property(nonatomic,strong) NSMapTable   * mapBlocks;
@property(nonatomic,strong) NSMutableSet * setOfHijackedClasses;

+(instancetype)sharedManager;
-(void)hijackDeallocForClass:(Class)theClass;
-(void)SH_memoryDebugger;
@end



@implementation SHKeyValueObserverBlocksManager

#pragma mark - Init & Dealloc
-(instancetype)init; {
    self = [super init];
    if (self) {
        self.mapBlocks            = [NSMapTable strongToStrongObjectsMapTable];
        self.setOfHijackedClasses = [NSMutableSet set];
        self.isAutoCleaning       = YES;
        //    [self SH_memoryDebugger];
    }
    
    return self;
}

+(instancetype)sharedManager; {
    static SHKeyValueObserverBlocksManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SHKeyValueObserverBlocksManager alloc] init];
        
    });
    
    return _sharedInstance;
    
}


#pragma mark - Swizzling
-(void)hijackDeallocForClass:(Class)theClass; {
    if ([self.setOfHijackedClasses containsObject:theClass] == NO) {
        
        SEL    deallocSelector               = NSSelectorFromString(@"dealloc");
        SEL    hijackedDeallocSelector       = NSSelectorFromString(@"hijackedDealloc");
        Method deallocMethod                 = class_getInstanceMethod(theClass, deallocSelector);
        Method hijackedDeallocMethod         = class_getInstanceMethod(theClass, hijackedDeallocSelector);
        
        IMP    hijackedDeallocImplementation = method_getImplementation(hijackedDeallocMethod);
        
        //merge hijackedDeallocImplementation on the deallocSelector
        class_replaceMethod(theClass,
                            deallocSelector,
                            hijackedDeallocImplementation,
                            method_getTypeEncoding(deallocMethod)
                            );
        
        
        [self.setOfHijackedClasses addObject:theClass];
    }
    
}

#pragma mark - Debugger
-(void)SH_memoryDebugger; {
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSLog(@"MAP %@",self.mapBlocks);
        NSLog(@"SET %@",self.setOfHijackedClasses);
        [self SH_memoryDebugger];
    });
}


@end

@interface NSObject ()


@end

typedef void (^SHKeyValueObserverBlockAdder)(void);
typedef void (^SHKeyValueObserverBlockModiferCompletion)(NSMutableDictionary * keyPathMap, NSMutableArray * addObservers);
typedef void (^SHKeyValueObserverBlockModifer)(NSMutableDictionary * keyPathMap, SHKeyValueObserverBlockModiferCompletion completionBlock);


@interface NSObject (SHKeyValueObserverBlocksPrivate)
-(void)SH_setupKeyPathMapBlock:(SHKeyValueObserverBlockModifer)theBlock;
-(void)SH_removeObserverForKeyPath:(NSString *)theKeyPath withContext:(NSString *)theContextString;
-(void)SH_hijackedDealloc;
-(void)SH_hijackDealloc;
@property(nonatomic,readonly) NSString               * SH_identifier;
@property(nonatomic,readonly)  NSMapTable            * SH_mapObserverBlocks;
@property(nonatomic,setter = SH_setMapObserverKeyPaths:) NSMutableDictionary   * SH_mapObserverKeyPaths;

@end

//static char SHKeyValueObserverBlocksContext;
@implementation NSObject (SHKeyValueObserverBlocks)


#pragma mark - Configuration
+(BOOL)SH_isAutoRemovingObservers; {
    return SHKeyValueObserverBlocksManager.sharedManager.isAutoCleaning;
}


+(void)SH_setAutoRemovingObservers:(BOOL)shouldRemoveObservers;{
    SHKeyValueObserverBlocksManager.sharedManager.isAutoCleaning = shouldRemoveObservers;
}


#pragma mark - Add Observers

-(NSString *)SH_addObserverForKeyPaths:(NSArray *)theKeyPaths
                                 block:(SHKeyValueObserverBlock)theBlock;  {
    
    return [self SH_addObserverForKeyPaths:theKeyPaths
                               withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior
                                     block:theBlock];
    
    
}


-(NSString *)SH_addObserverForKeyPaths:(NSArray *)theKeyPaths
                           withOptions:(NSKeyValueObservingOptions)theOptions
                                 block:(SHKeyValueObserverBlock)theBlock; {
    [self SH_hijackDealloc];
    
    NSString * identifier = [[NSUUID UUID] UUIDString];
    NSMutableArray * listOfBlocks = @[].mutableCopy;
    [self SH_setupKeyPathMapBlock:^void (NSMutableDictionary * keyPathMap, SHKeyValueObserverBlockModiferCompletion theCompletionBlock) {
        
        for (NSString * keyPath in theKeyPaths) {
            
            NSMutableDictionary *  identifiers = keyPathMap[keyPath];
            if(identifiers == nil) identifiers = @{}.mutableCopy;
            
            NSMutableArray *  blocks = identifiers[identifier];
            if(blocks == nil) blocks = @[].mutableCopy;
            
            [blocks addObject:[theBlock copy]];
            identifiers[identifier] = blocks;
            
            SHKeyValueObserverBlockAdder createObserverBlock = ^() {
                [self addObserver:self forKeyPath:keyPath
                          options:theOptions
                          context:(__bridge void *)(identifier)];
            };
            [listOfBlocks addObject:[createObserverBlock copy]];
            keyPathMap[keyPath] = identifiers;
        }
        theCompletionBlock(keyPathMap,listOfBlocks);
        
    }];
    return identifier;
    
}


#pragma mark - Helpers
-(BOOL)SH_handleObserverForKeyPath:(NSString *)theKeyPath
                        withChange:(NSDictionary *)theChange
                           context:(void *)context; {
    
    NSString            * contextUUID  = (__bridge NSString *)(context);
    NSMutableDictionary * identifiers  = self.SH_mapObserverKeyPaths[theKeyPath];
    BOOL isHandlingObserver = NO;
    if ([identifiers objectForKey:contextUUID]) {
        isHandlingObserver = YES;
        [identifiers.allValues enumerateObjectsUsingBlock:^(NSArray * blocks, NSUInteger _, BOOL * __) {
            [blocks enumerateObjectsUsingBlock:^(SHKeyValueObserverBlock block, NSUInteger idx, BOOL *stop) {
                if(block) block(self,theKeyPath,theChange);
            }];
        }];
    }
    return isHandlingObserver;
    
}




#pragma mark - Remove Observers


-(void)SH_removeObserversForKeyPaths:(NSArray *)theKeyPaths
                     withIdentifiers:(NSArray *)theIdentifiers;  {
    
    [self SH_setupKeyPathMapBlock:^void(NSMutableDictionary *keyPathMap, SHKeyValueObserverBlockModiferCompletion theCompletionBlock) {
        NSMutableArray * keyPathsToRemove = @[].mutableCopy;
        for (NSString * keyPath in theKeyPaths) {
            NSMutableDictionary * identifiers =  keyPathMap[keyPath];
            
            for (NSString * identifier in theIdentifiers) {
                NSMutableArray * blocks = identifiers[identifier];
                for (SHKeyValueObserverBlock block in blocks) {
                    [self SH_removeObserverForKeyPath:keyPath withContext:identifier];
                }
                [identifiers removeObjectForKey:identifier];
            }
            if(identifiers.count < 1)
                [keyPathsToRemove addObject:keyPath];
        }
        [keyPathMap removeObjectsForKeys:keyPathsToRemove];
        theCompletionBlock(keyPathMap,nil);
    }];
    
}


-(void)SH_removeObserversWithIdentifiers:(NSArray *)theIdentifiers; {
    
    __weak typeof(self) weakSelf = self;
    [self SH_setupKeyPathMapBlock:^void(NSMutableDictionary * keyPathMap, SHKeyValueObserverBlockModiferCompletion theCompletionBlock) {
        
        NSMutableArray * keyPathsToRemove = @[].mutableCopy;
        for (NSString * identifierToRemove in theIdentifiers) {
            for (NSString * keyPath in keyPathMap) {
                NSMutableDictionary * identifiers = keyPathMap[keyPath];
                [identifiers removeObjectForKey:identifierToRemove];
                [weakSelf SH_removeObserverForKeyPath:keyPath withContext:identifierToRemove];
                if(identifiers.count < 1)
                    [keyPathsToRemove addObject:keyPath];
            }
        }
        
        [keyPathMap removeObjectsForKeys:keyPathsToRemove];
        theCompletionBlock(keyPathMap,nil);
        
    }];
    
    
    
}

-(void)SH_removeObserversForKeyPaths:(NSArray *)theKeyPaths; {
    [self SH_setupKeyPathMapBlock:^void(NSMutableDictionary * keyPathMap, SHKeyValueObserverBlockModiferCompletion theCompletionBlock) {
        for (NSString * keyPath in theKeyPaths) {
            NSMutableDictionary * identifiers =  keyPathMap[keyPath];
            
            for (NSString * identifier in identifiers.allKeys)
                [self SH_removeObserverForKeyPath:keyPath withContext:identifier];
            
            [keyPathMap removeObjectForKey:keyPath];
            
        }
        theCompletionBlock(keyPathMap,nil);
    }];
}

-(void)SH_removeAllObservers; {
    self.SH_mapObserverKeyPaths = nil;
}



#pragma mark - Privates


#pragma mark - Properties


#pragma mark - Getters
-(NSMutableDictionary *)SH_mapObserverKeyPaths; {
    NSMutableDictionary * mapObserverKeyPaths = [self.SH_mapObserverBlocks objectForKey:self.SH_identifier];
    if(mapObserverKeyPaths == nil) {
        mapObserverKeyPaths = @{}.mutableCopy;
    }
    
    return mapObserverKeyPaths;
}


#pragma mark - Setters
-(void)SH_setMapObserverKeyPaths:(NSMutableDictionary *)mapObserverKeypaths; {
    if(mapObserverKeypaths.count > 0)
        [self.SH_mapObserverBlocks setObject:mapObserverKeypaths forKey:self.SH_identifier];
    else if(self.SH_mapObserverKeyPaths.count > 0) {
        [self SH_removeObserversForKeyPaths:self.SH_mapObserverKeyPaths.allKeys];
    }
    //  else
    //    [self.mapObserverBlocks removeObjectForKey:self.identifier];
    
    
}



#pragma mark - Helpers
-(void)SH_setupKeyPathMapBlock:(SHKeyValueObserverBlockModifer)theBlock; {
    theBlock(self.SH_mapObserverKeyPaths, ^(NSMutableDictionary * observerPaths, NSMutableArray * blocks){
        
        self.SH_mapObserverKeyPaths = observerPaths;
        
        for (SHKeyValueObserverBlockAdder block in blocks) {
            block();
        }
    });
    
    
}
-(void)SH_removeObserverForKeyPath:(NSString *)theKeyPath withContext:(NSString *)theContextString; {
    [self removeObserver:self forKeyPath:theKeyPath context:(__bridge void *)(theContextString)];
}

static char *kDisgustingSwizzledVariableKey;
-(NSString *)SH_identifier; {
    NSString * _identifier = objc_getAssociatedObject(self, kDisgustingSwizzledVariableKey);
    if(_identifier == nil) {
        _identifier = [[NSUUID UUID] UUIDString];
        objc_setAssociatedObject(self, kDisgustingSwizzledVariableKey, _identifier, OBJC_ASSOCIATION_ASSIGN);
    }
    return _identifier;
}

-(NSMapTable *)SH_mapObserverBlocks; {
    return SHKeyValueObserverBlocksManager.sharedManager.mapBlocks;
}


#pragma mark - Dealloc
-(void)SH_hijackedDealloc; {
    [self SH_removeAllObservers];
}

-(void)SH_hijackDealloc; {
    if([NSObject SH_isAutoRemovingObservers]) {
        Class class = [self class];
        [SHKeyValueObserverBlocksManager.sharedManager hijackDeallocForClass:class];
    }
}


#pragma mark - Standard Observer
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context; {
    [self SH_handleObserverForKeyPath:keyPath withChange:change context:context];
}
#pragma clang diagnostic pop

@end
