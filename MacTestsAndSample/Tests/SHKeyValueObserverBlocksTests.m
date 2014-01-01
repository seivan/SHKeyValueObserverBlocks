//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"



@interface SHKeyValueObserverBlocksTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverBlocksTests


#pragma mark - Add Observers



-(void)testSH_addObserverForKeyPath_block; {
  __block BOOL assertGetCalled = NO;
  __weak typeof(self) weakSelf = self;
  [self.model SH_addObserverForKeyPath:@"isDead" block:^(NSKeyValueChange changeType, NSObject * oldValue, NSObject * newValue, NSIndexPath *indexPath) {
    XCTAssertEqual(changeType, NSKeyValueChangeSetting);
    XCTAssertNil(indexPath);
    if(weakSelf.model.isDead) {
      XCTAssertFalse(((NSNumber *)oldValue).boolValue);
      XCTAssertTrue(((NSNumber *)newValue).boolValue);
      assertGetCalled = YES;
    }
    else {
      XCTAssertTrue(((NSNumber *)oldValue).boolValue);
      XCTAssertFalse(((NSNumber *)newValue).boolValue);
      assertGetCalled = YES;
    }
    

    
  }];
  
  XCTAssertFalse(assertGetCalled);
  self.model.isDead = YES;
  [self SH_waitForTimeInterval:1.f];
  XCTAssertTrue(assertGetCalled);

  assertGetCalled = NO;
  self.model.isDead = NO;
  [self SH_waitForTimeInterval:1.f];
  XCTAssertTrue(assertGetCalled);

  
}


-(void)testSH_addObserverForKeyPaths_withOptions_block; {
  __block BOOL assertForIsDead = NO;
  __block BOOL assertForAge = NO;
  BOOL secondRound = NO;
  [self.model SH_addObserverForKeyPaths:@[@"isDead", @"age"] withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(NSString *keyPath, NSDictionary *change) {
    if(secondRound) {
      XCTAssertNotNil(change[NSKeyValueChangeNewKey]);
    }
    if([keyPath isEqualToString:@"isDead"]) {
      assertForIsDead = YES;
      
    }
    
    if([keyPath isEqualToString:@"age"]) {
      assertForAge = YES;
    }
  }];
  
  XCTAssertTrue(assertForAge);
  XCTAssertTrue(assertForIsDead);
  
  assertForAge = NO;
  assertForIsDead = NO;
  
  secondRound = YES;
  self.model.isDead = YES;
  self.model.age = @(34);
  [self SH_waitForTimeInterval:0.5f];
  XCTAssertTrue(assertForAge);
  XCTAssertTrue(assertForIsDead);
  
}




#pragma mark - Remove Observers
-(void)testSH_removeAllObserversWithIdentifiers; {
  __block BOOL assertForIsDead = NO;
  __block BOOL assertForAge = NO;
  NSString * identifier = [self.model SH_addObserverForKeyPaths:@[@"isDead", @"age"] withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(NSString *keyPath, NSDictionary *change) {

    if([keyPath isEqualToString:@"isDead"]) {
      assertForIsDead = YES;
      
    }
    
    if([keyPath isEqualToString:@"age"]) {
      assertForAge = YES;
    }
  }];
  
  XCTAssertTrue(assertForAge);
  XCTAssertTrue(assertForIsDead);
  
  assertForAge = NO;
  assertForIsDead = NO;
  
  [self.model SH_removeAllObserversWithIdentifiers:@[identifier]];
  self.model.isDead = YES;
  self.model.age = @(34);
  [self SH_waitForTimeInterval:0.5f];
  XCTAssertFalse(assertForAge);
  XCTAssertFalse(assertForIsDead);

}

-(void)testSH_removeAllObserversForKeyPaths; {
  __block BOOL assertForIsDead = NO;
  __block BOOL assertForAge = NO;
  [self.model SH_addObserverForKeyPaths:@[@"isDead", @"age"] withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(NSString *keyPath, NSDictionary *change) {
    
    if([keyPath isEqualToString:@"isDead"]) {
      assertForIsDead = YES;
      
    }
    
    if([keyPath isEqualToString:@"age"]) {
      assertForAge = YES;
    }
  }];
  
  XCTAssertTrue(assertForAge);
  XCTAssertTrue(assertForIsDead);
  
  assertForAge = NO;
  assertForIsDead = NO;
  
  [self.model SH_removeAllObserversForKeyPaths:@[@"isDead"]];
  self.model.isDead = YES;
  self.model.age = @(34);
  [self SH_waitForTimeInterval:0.5f];
  XCTAssertTrue(assertForAge);
  XCTAssertFalse(assertForIsDead);

}

-(void)testSH_removeAllObservers; {
  __block BOOL assertForIsDead = NO;
  __block BOOL assertForAge = NO;
  [self.model SH_addObserverForKeyPaths:@[@"isDead", @"age"] withOptions:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(NSString *keyPath, NSDictionary *change) {
    
    if([keyPath isEqualToString:@"isDead"]) {
      assertForIsDead = YES;
      
    }
    
    if([keyPath isEqualToString:@"age"]) {
      assertForAge = YES;
    }
  }];
  
  XCTAssertTrue(assertForAge);
  XCTAssertTrue(assertForIsDead);
  
  assertForAge = NO;
  assertForIsDead = NO;
  
  [self.model SH_removeAllObservers];
  self.model.isDead = YES;
  self.model.age = @(34);
  [self SH_waitForTimeInterval:0.5f];
  XCTAssertFalse(assertForAge);
  XCTAssertFalse(assertForIsDead);
  
}


@end
