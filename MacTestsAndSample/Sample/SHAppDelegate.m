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
@property(nonatomic,strong) NSOrderedSet          * playersOrderedSet;
@property(nonatomic,strong) NSSet                 * playersSet;
@property(nonatomic,strong) NSArray               * playersArray;
@property(nonatomic,strong) NSMutableDictionary   * playersDictionary;
@property(nonatomic,strong) NSMutableDictionary   * othersDictionary;

@property(nonatomic,strong) NSMutableString * gender;
@property(nonatomic,strong) NSNumber        * age;
@property(nonatomic,strong) NSString        * name;
@property(nonatomic,assign) CGSize            size;
@property(nonatomic,assign) BOOL              isDead;

@end


@implementation SHAppDelegate


-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;{

  NSString * path = @"playersArray";
  [self SH_addObserverForKeyPath:path block:^(NSKeyValueChange changeType, NSString * oldValue, NSString * newValue, NSIndexPath *indexPath) {
    switch (changeType) {
      case NSKeyValueChangeSetting:
        NSLog(@"Setting %@", newValue);
        break;
      case NSKeyValueChangeInsertion:
        NSLog(@"Inserting %@", newValue);
        break;
      case NSKeyValueChangeRemoval:
        NSLog(@"Removal %@", oldValue);
        break;
      case NSKeyValueChangeReplacement:
        NSLog(@"ChangeReplacement %@ with %@", oldValue, newValue);
        break;
      default:
        break;
    }
  }];
  
  NSLog(@"Starting with NSArray");

  self.playersArray = @[@"Python"];
  [[self mutableArrayValueForKey:path] addObject:@"C++"];
  [[self mutableArrayValueForKey:path] addObject:@"Objective-c"];
  [[self mutableArrayValueForKey:path] replaceObjectAtIndex:0 withObject:@"Ruby"];
  [[self mutableArrayValueForKey:path] removeObject:@"C++"];
  NSLog(@"%@", self.playersArray);
//
//  
  [self SH_setBindingUniObserverKeyPath:@"playersDictionary.myKey" toObject:self withKeyPath:@"othersDictionary.myKey" transformValueBlock:^id(id object, NSString *keyPath, id newValue, BOOL *shouldAbort) {
    return newValue;
  }];

  [self SH_setBindingUniObserverKeyPath:@"playersDictionary" toObject:self withKeyPath:@"othersDictionary" transformValueBlock:^id(id object, NSString *keyPath, id newValue, BOOL *shouldAbort) {
    return ((NSObject *)newValue).mutableCopy ;
  }];

  
  self.playersDictionary = @{@"1" : @"One",
                             @"2" : @"Two",
                            }.mutableCopy;

  
  NSLog(@"the Dictionary: %@", self.othersDictionary);
  
  self.playersDictionary[@"myKey"] = @"setting key";
  NSLog(@"the Dictionary: %@", self.othersDictionary);
  
  [self.playersDictionary removeObjectForKey:@"myKey"];
  NSLog(@"the Dictionary: %@", self.othersDictionary);

  
  
  
}

@end
