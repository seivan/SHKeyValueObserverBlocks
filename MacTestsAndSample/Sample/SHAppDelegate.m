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
  
  
  [self SH_addObserverForKeyPaths:@[@"playersDictionary.allKeys"] withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionNew block:^(NSString *keyPath, NSDictionary *change) {
    NSLog(@"%@ - %@", keyPath, change);
  }];
  
  self.playersDictionary = @{}.mutableCopy;
  [self.playersDictionary willChangeValueForKey:@"allKeys"];
  self.playersDictionary[@"lol"] = @"Seivan";
  [self.playersDictionary didChangeValueForKey:@"allKeys"];
  
  
  [self SH_addObserverForKeyPath:@"playersArray" block:^(NSKeyValueChange changeType, NSObject * oldValue, NSObject * newValue, NSIndexPath *indexPath) {
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
        NSLog(@"ChangeReplacement %@", newValue);
        break;
      default:
        break;
    }
  }];
  
  NSLog(@"Starting with NSArray");
  NSString * path = @"playersArray";
  self.playersArray = @[@"Python"];
  [[self mutableArrayValueForKey:path] addObject:@"C++"];
  [[self mutableArrayValueForKey:path] addObject:@"Objective-c"];
  [[self mutableArrayValueForKey:path] replaceObjectAtIndex:0 withObject:@"Ruby"];
  [[self mutableArrayValueForKey:path] removeObject:@"C++"];
  NSLog(@"%@", self.playersArray);
//
//  
  [self SH_setBindingUniObserverKeyPath:@"playersDictionary.myKey" toObject:self withKeyPath:@"othersDictionary.myKey" transformValueBlock:^id(NSObject *object, NSString *keyPath, NSObject * newValue, BOOL *shouldAbort) {
    return newValue;
  }];

  [self SH_setBindingUniObserverKeyPath:@"playersDictionary" toObject:self withKeyPath:@"othersDictionary" transformValueBlock:^id(NSObject *object, NSString *keyPath, NSObject * newValue, BOOL *shouldAbort) {
    return newValue.mutableCopy ;
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
