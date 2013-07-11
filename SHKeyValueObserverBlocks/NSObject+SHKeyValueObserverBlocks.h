//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs



typedef void (^SHKeyValueObserverBlock)(id weakSelf, NSString *keyPath, NSDictionary *change);

@interface NSObject (SHKeyValueObserverBlocks)
#pragma mark -
#pragma mark Configuration

#pragma mark -
#pragma mark Property
+(BOOL)SH_isAutoRemovingObservers;
+(void)SH_isAutoRemovingObservers:(BOOL)shouldRemoveObservers;
#pragma mark - 
#pragma mark Create Observers

-(NSString *)SH_addObserverForKeyPaths:(NSSet *)theKeyPaths
                                 block:(SHKeyValueObserverBlock)theBlock;

-(NSString *)SH_addObserverForKeyPaths:(NSSet *)theKeyPaths
                           withOptions:(NSKeyValueObservingOptions)theOptions
                                 block:(SHKeyValueObserverBlock)theBlock;


#pragma mark -
#pragma mark Helpers
-(BOOL)SH_handleObserverForKeyPath:(NSString *)theKeyPath
                        withChange:(NSDictionary *)theChange
                           context:(void *)context;


#pragma mark -
#pragma mark Remove Observers
-(void)SH_removeObserversForKeyPaths:(NSSet *)theKeyPaths
                         withIdentifiers:(NSSet *)theIdentifiers;

-(void)SH_removeObserversWithIdentifiers:(NSSet *)theIdentifiers;

-(void)SH_removeObserversForKeyPaths:(NSSet *)theKeyPaths;

-(void)SH_removeAllObservers;

@end
