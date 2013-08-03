//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"

@implementation SHKeyValueObserverSuper

-(void)setUp; {
  [super setUp];
  self.player = SHPlayer.new;
  
  self.firstBlockDidPassTestForBackPackArray = NO;
  self.firstBlockDidPassTestForPocketSet     = NO;
  
  self.secondBlockDidPassTestForBackPackArray = NO;
  self.secondBlockDidPassTestForPocketSet     = NO;
  
  
  self.backPackArrayKeyPath  = @"player.backPackArray.items";
  self.pocketSetKeyPath      = @"player.pocketSet.items";
  
  self.firstIdentifier = [self SH_addObserverForKeyPaths:@[self.backPackArrayKeyPath, self.pocketSetKeyPath] withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    STAssertEqualObjects(self, weakSelf, nil);
    STAssertNotNil(keyPath, nil);
    STAssertNotNil(change, nil);
    if([keyPath isEqualToString:self.backPackArrayKeyPath])
      self.firstBlockDidPassTestForBackPackArray = YES;
    if([keyPath isEqualToString:self.pocketSetKeyPath])
      self.firstBlockDidPassTestForPocketSet = YES;
  }];
  
  self.secondIdentifier = [self SH_addObserverForKeyPaths:@[self.backPackArrayKeyPath, self.pocketSetKeyPath] withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    STAssertEqualObjects(self, weakSelf, nil);
    STAssertNotNil(keyPath, nil);
    STAssertNotNil(change, nil);
    if([keyPath isEqualToString:self.backPackArrayKeyPath])
      self.secondBlockDidPassTestForBackPackArray = YES;
    if([keyPath isEqualToString:self.pocketSetKeyPath])
      self.secondBlockDidPassTestForPocketSet = YES;
  }];


  
  
}
-(void)tearDown; {
  [super tearDown];
}


@end
