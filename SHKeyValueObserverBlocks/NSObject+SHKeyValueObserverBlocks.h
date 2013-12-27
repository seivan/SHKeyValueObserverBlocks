//
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#pragma mark - Block Defs


typedef void (^SHKeyValueObserverSplatBlock)(NSKeyValueChange changeType,
                                             id<NSObject> oldValue, id<NSObject> newValue,
                                             NSIndexPath * indexPath);

typedef void (^SHKeyValueObserverDefaultBlock)(NSString * keyPath,
                                               NSDictionary * change);

typedef id(^SHKeyValueObserverBindingTransformBlock)(NSObject * object,
                                                     NSString * keyPath,
                                                     id<NSObject> newValue,
                                                     BOOL *shouldAbort);

@interface NSObject (SHKeyValueObserverBlocks)

#pragma mark - Config
+(BOOL)SH_isAutoRemovingObservers;
+(void)SH_setAutoRemovingObservers:(BOOL)isAutoRemovingObservers;

#pragma mark - Properties
@property(nonatomic,readonly) NSDictionary * SH_observedKeyPaths;

#pragma mark - Add Observers

-(NSString *)SH_addObserverForKeyPath:(NSString *)theKeyPath
                                 block:(SHKeyValueObserverSplatBlock)theBlock;


-(NSString *)SH_addObserverForKeyPaths:(NSArray *)theKeyPaths
                           withOptions:(NSKeyValueObservingOptions)theOptions
                                 block:(SHKeyValueObserverDefaultBlock)theBlock;


#pragma mark - Set Bindings


-(NSArray *)SH_setBindingObserverKeyPath:(NSString *)theKeyPath
                                toObject:(NSObject *)theObject
                             withKeyPath:(NSString *)theOtherKeyPath;

-(NSString *)SH_setBindingUniObserverKeyPath:(NSString *)theKeyPath
                                    toObject:(NSObject *)theObject
                                 withKeyPath:(NSString *)theOtherKeyPath;

-(NSString *)SH_setBindingUniObserverKeyPath:(NSString *)theKeyPath
                                    toObject:(NSObject *)theObject
                                 withKeyPath:(NSString *)theOtherKeyPath
                             transformValueBlock:(SHKeyValueObserverBindingTransformBlock)theBlock;









#pragma mark - Remove Observers
-(void)SH_removeAllObserversWithIdentifiers:(NSArray *)theIdentifiers;
-(void)SH_removeAllObserversForKeyPaths:(NSArray *)theKeyPaths;
-(void)SH_removeAllObservers;


@end
