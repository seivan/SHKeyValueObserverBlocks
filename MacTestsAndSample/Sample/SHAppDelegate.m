//
//  SHAppDelegate.m
//  OSX-Example
//
//  Created by Seivan Heidari on 7/9/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHModel.h"
#import "SHKeyValueObserverBlocks.h"








@interface SHAppDelegate ()
@property(nonatomic,strong) SHModel    * model;
@property(nonatomic,strong) SHSubModel * subModel;
@end


@implementation SHAppDelegate


-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;{
  self.model    = SHModel.new;
  self.subModel = SHSubModel.new;
  [self.model SH_addObserverForKeyPath:@"playersArray" block:^(NSKeyValueChange changeType, id<NSObject> oldValue, id<NSObject> newValue, NSIndexPath *indexPath) {
    NSLog(@"changeType: %lu, \n oldValue: %@, \n newValue: %@ \n indexPath: %@ \n", changeType, oldValue, newValue, indexPath);
  }];
  
  self.model.playersArray = @[];
  
  
  [[self.model mutableArrayValueForKey:@"playersArray"] addObject:@"Christopher"];
  
  [[self.model mutableArrayValueForKey:@"playersArray"] removeObjectAtIndex:0];
  
  

//  [self.model SH_setBindingObserverKeyPath:@"isDead" toObject:self.subModel withKeyPath:@"isDead"];
//   
//  NSParameterAssert(self.model.isDead == NO);
//  NSParameterAssert(self.subModel.isDead == NO);
//
//  self.model.isDead = YES;
//  
//  NSParameterAssert(self.model.isDead);
//  NSParameterAssert(self.subModel.isDead);
//
//  self.subModel.isDead = NO;
//  
//  NSParameterAssert(self.model.isDead == NO);
//  NSParameterAssert(self.subModel.isDead == NO);
//
//  self.model.isDead = YES;
//  
//  NSParameterAssert(self.model.isDead);
//  NSParameterAssert(self.subModel.isDead);
//
//  self.subModel.isDead = NO;
//  
//  NSParameterAssert(self.model.isDead == NO);
//  NSParameterAssert(self.subModel.isDead == NO);
//
//  
////  self.subModel = nil;
//  self.model = nil;
//  
//  self.model.isDead = NO;
//  NSParameterAssert(self.model.isDead == NO);
//  NSParameterAssert(self.subModel.isDead == NO);
//
//  self.model.isDead = NO;
//  NSParameterAssert(self.model.isDead == NO);
//  NSParameterAssert(self.subModel.isDead == NO);


//  [self.model SH_addObserverForKeyPaths:@[@"isDead"] withOptions:kNilOptions block:^(NSString *keyPath, NSDictionary *change) {
//    NSLog(@"FIRST: keyPath: %@ \n NSKeyValueChangeKindKey: %@ \n  NSKeyValueChangeNewKey: %@ \n NSKeyValueChangeOldKey: %@ \n NSKeyValueChangeIndexesKey: %@ \n NSKeyValueChangeNotificationIsPriorKey: %@",
//          keyPath,
//          change[NSKeyValueChangeKindKey],
//          change[NSKeyValueChangeNewKey],
//          change[NSKeyValueChangeOldKey],
//          change[NSKeyValueChangeIndexesKey],
//          change[NSKeyValueChangeNotificationIsPriorKey]);
//
//  }];
//  [self.subModel SH_addObserverForKeyPaths:@[@"isDead"] withOptions:kNilOptions block:^(NSString *keyPath, NSDictionary *change) {
//    NSLog(@"FIRST: keyPath: %@ \n NSKeyValueChangeKindKey: %@ \n  NSKeyValueChangeNewKey: %@ \n NSKeyValueChangeOldKey: %@ \n NSKeyValueChangeIndexesKey: %@ \n NSKeyValueChangeNotificationIsPriorKey: %@",
//          keyPath,
//          change[NSKeyValueChangeKindKey],
//          change[NSKeyValueChangeNewKey],
//          change[NSKeyValueChangeOldKey],
//          change[NSKeyValueChangeIndexesKey],
//          change[NSKeyValueChangeNotificationIsPriorKey]);
//    
//  }];
//
//  [self.subModel SH_addObserverForKeyPaths:@[@"subModelStuff"] withOptions:kNilOptions block:^(NSString *keyPath, NSDictionary *change) {
//    NSLog(@"FIRST: keyPath: %@ \n NSKeyValueChangeKindKey: %@ \n  NSKeyValueChangeNewKey: %@ \n NSKeyValueChangeOldKey: %@ \n NSKeyValueChangeIndexesKey: %@ \n NSKeyValueChangeNotificationIsPriorKey: %@",
//          keyPath,
//          change[NSKeyValueChangeKindKey],
//          change[NSKeyValueChangeNewKey],
//          change[NSKeyValueChangeOldKey],
//          change[NSKeyValueChangeIndexesKey],
//          change[NSKeyValueChangeNotificationIsPriorKey]);
//    
//  }];


  double delayInSeconds = 112.0;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//  [self.model SH_removeObserversWithIdentifiers:@[identifier]];
//  [self.model SH_removeAllObservers];
    self.subModel = nil;

  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    self.model = nil;
//    [self.model SH_removeAllObserversForKeyPaths:@[@"isDead"]];

  });

});


  
//  NSString * identifier = [self SH_addObserverForKeyPaths:@[@"playersOrderedSet",
//                                                            @"playersSet",
//                                                            @"playersArray",
//                                                            @"playersDictionary",
//                                                            @"gender",
//                                                            @"age",
//                                                            @"name",
//                                                            @"size",
//                                                            @"isDead"
//                                                            ]
//                                              withOptions:
//                           NSKeyValueObservingOptionInitial
//                           |NSKeyValueObservingOptionOld
//                           |NSKeyValueObservingOptionNew
//                                                    block:^(NSString *keyPath, NSDictionary *change) {
//                                                      NSLog(@"keyPath: %@ \n NSKeyValueChangeKindKey: %@ \n  NSKeyValueChangeNewKey: %@ \n NSKeyValueChangeOldKey: %@ \n NSKeyValueChangeIndexesKey: %@ \n NSKeyValueChangeNotificationIsPriorKey: %@",
//                                                            keyPath,
//                                                            change[NSKeyValueChangeKindKey],
//                                                            change[NSKeyValueChangeNewKey],
//                                                            change[NSKeyValueChangeOldKey],
//                                                            change[NSKeyValueChangeIndexesKey],
//                                                            change[NSKeyValueChangeNotificationIsPriorKey]
//                                                            );
//                                                      
//                                                      if([change[NSKeyValueChangeNewKey] isKindOfClass:[NSValue class]]) {
//                                                        CGSize size = CGSizeZero;
//                                                        [change[NSKeyValueChangeNewKey] getValue:&size];
//                                                        NSLog(@"SIZE %@", NSStringFromSize(size));
//                                                      }
//                                                      
//                                                      
//                                                    }];
//  
//  
//  
//  
//  
//
//#pragma mark - Array
//  
//  self.playersArray = @[@(1),@"2s"];
//  
//  self.playersArray = @[@(1),@"2s"];
//  
//  self.playersArray = nil;
//  
//  self.playersArray = @[@(1),@"2s"];
//  
//  self.playersArray = nil;
//  
//  self.playersArray = @[@(1),@"2s"];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] addObject:@(3)];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] addObject:@"First"];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] addObjectsFromArray:@[@(666),@(999)]];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] insertObject:@"X" atIndex:2];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] removeObject:@"First"];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] removeObjectAtIndex:0];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] removeObject:@"2s"];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] removeObject:@"2s"];
//  
//  [[self mutableArrayValueForKey:@"playersArray"] removeAllObjects];
//  
//
//  
//  self.playersSet = [NSSet setWithArray:@[@(1),@"2s"]];
//  
//  self.playersSet = [NSSet setWithArray:@[@(1),@"2s"]];
//  
//  self.playersSet = nil;
//  
//  self.playersSet = [NSSet setWithArray:@[@(1),@"2s"]];
//
//  self.playersSet = nil;
//  
//  self.playersSet = [NSSet setWithArray:@[@(1),@"2s"]];
//
//  [[self mutableSetValueForKey:@"playersSet"] addObject:@(3)];
//
//  [[self mutableSetValueForKey:@"playersSet"] addObject:@"First"];
//  
//  [[self mutableSetValueForKey:@"playersSet"] addObjectsFromArray:@[@(666),@(999)]];
//
//  [[self mutableSetValueForKey:@"playersSet"] removeObject:@"First"];
//  
//  [[self mutableSetValueForKey:@"playersSet"] removeAllObjects];
//
//#pragma mark - OrederedSet
//  
//  self.playersOrderedSet = [NSOrderedSet orderedSetWithArray:@[@(1),@"2s"]];
//  
//  self.playersOrderedSet = [NSOrderedSet orderedSetWithArray:@[@(1),@"2s"]];
//  
//  self.playersOrderedSet = nil;
//  
//  self.playersOrderedSet = [NSOrderedSet orderedSetWithArray:@[@(1),@"2s"]];
//  
//  self.playersOrderedSet = nil;
//  
//  self.playersOrderedSet = [NSOrderedSet orderedSetWithArray:@[@(1),@"2s"]];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] addObject:@(3)];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] addObject:@"First"];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] addObjectsFromArray:@[@(666),@(999)]];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] removeObject:@"First"];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] removeObjectAtIndex:0];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] removeObject:@"2s"];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] removeObject:@"2s"];
//  
//  [[self mutableOrderedSetValueForKey:@"playersOrderedSet"] removeAllObjects];
//  
//  #pragma mark - MutableString
//  
//  self.gender = @"LOL".mutableCopy;
//  
//  [self.gender appendString:@" CAT"];
//  
//  [self.gender insertString:@"mid" atIndex:3];
//  
//  [self.gender deleteCharactersInRange:NSMakeRange(0, 2)];
//  
//  self.gender = @"".mutableCopy;
//  
//  self.gender = nil;
//
//#pragma mark - NSNUMBer
//  
//  
//  self.age = @(22);
//  
//  self.age = nil;
//  
//  self.age = @(24);
//  
//#pragma mark - NSString
//  
//  self.name = @"LOL";
//  
//  self.name = @"CAT";
//  
//  self.name = nil;
//  
//  self.name = @"DOG";
//  
//  self.name = @"";
//
//  
//#pragma mark - CGSize
//  
//  self.size  = CGSizeMake(23, 23);
//  
//  self.size = CGSizeMake(666, 666);
//  
//  self.size = CGSizeZero;
//  
//  self.size = CGSizeZero;
//  
//  self.size = CGSizeMake(666, 666);
//  
//  self.size = CGSizeMake(666, 666);
//
//
//  
//#pragma mark - BOOL
//  
//  self.isDead = NO;
//  
//  self.isDead = NO;
//  
//  self.isDead = YES;


}




//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;  {
//  if([self SH_handleObserverForKeyPath:keyPath withChange:change context:context])
//    NSLog(@"TAKEN CARE OF BY BLOCK");
//  else
//    NSLog(@"Take care of here!");
//  
//}


@end
