//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"




@interface SHKeyValueObserverBindingsTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverBindingsTests


#pragma mark - Add Bindings
-(void)testSetBinding; {
  NSString * path = @"playersArray";
  [self.model SH_setBindingObserverKeyPath:path toObject:self.subModel withKeyPath:path];
  
  NSArray * sample = @[@(1), @(2)];
  self.subModel.playersArray = sample;
  XCTAssertEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertEqualObjects(sample, self.model.playersArray);
  

  self.model.playersArray = @[];
  XCTAssertEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.subModel.playersArray);
  

  self.subModel.playersArray = nil;
  
  XCTAssertNil(self.model.playersArray);
  XCTAssertNil(self.subModel.playersArray);
  
  
  self.model.playersArray = sample;
  XCTAssertEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertEqualObjects(sample, self.model.playersArray);

}

-(void)testBindingsWithStruct; {
  NSString * keyPath = @"size";
  [self.model SH_setBindingObserverKeyPath:keyPath toObject:self.subModel withKeyPath:keyPath];
  CGSize size = CGSizeMake(666, 666);
  self.subModel.size = size;
  XCTAssertEqual(size, self.model.size);
}


-(void)testSetBindingsWithEnumerations; {
  NSString * path = @"playersArray";
  NSArray * sample = @[@(1), @(2)];
  self.subModel.playersArray = sample;
  [self.model SH_setBindingObserverKeyPath:path toObject:self.subModel withKeyPath:path];
  
  


  [[self.subModel mutableArrayValueForKey:path] replaceObjectAtIndex:0 withObject:@"Seivan"];
  XCTAssert([self.model.playersArray containsObject:@"Seivan"]);
  XCTAssertFalse([self.model.playersArray containsObject:@(1)]);

  [[self.subModel mutableArrayValueForKey:path] removeObject:@"Seivan"];
  XCTAssertFalse([self.model.playersArray containsObject:@"Seivan"]);

  [[self.subModel mutableArrayValueForKey:path] addObject:@"Seivan"];
  XCTAssert([self.model.playersArray containsObject:@"Seivan"]);
  

}

-(void)testSetBindingsWithKeyedEnumerations; {

  NSString * path = @"playersDictionary";


  XCTAssertNil(self.subModel.playersDictionary);
  XCTAssertNil(self.model.playersDictionary);
  XCTAssertNotEqual(self.model, self.subModel);
  
  [self.subModel SH_setBindingObserverKeyPath:path toObject:self.model withKeyPath:path];
  
  
  self.subModel.playersDictionary = @{@"seivan" : @(0)}.mutableCopy;
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  XCTAssertEqualObjects(@{@"seivan" : @(0)}.mutableCopy, self.model.playersDictionary);
  
  [self.subModel.playersDictionary setObject:@(1) forKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);

  [self.subModel.playersDictionary removeObjectForKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
  [self.subModel.playersDictionary setObject:@(3) forKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);

  [self.subModel.playersDictionary setObject:@(99) forKey:@"chris"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
}


-(void)testSetUniBindningWithBlock; {
  NSString * path = @"playersArray";
  __block BOOL assertBlockGotCalled = NO;
  __block BOOL isAborting = NO;
  [self.subModel SH_setBindingUniObserverKeyPath:path toObject:self.model withKeyPath:path transformValueBlock:^id(NSObject *object, NSString *keyPath, id<NSObject> newValue, BOOL *shouldAbort) {
    XCTAssertEqualObjects(keyPath, path);
    XCTAssertEqualObjects(object, self.subModel);
    assertBlockGotCalled = YES;
    *shouldAbort = isAborting;
    return newValue;
  }];
  
  
  
  NSArray * sample = @[@(1), @(2)];
  self.subModel.playersArray = sample;
  XCTAssert(assertBlockGotCalled);
  XCTAssertEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertEqualObjects(sample, self.model.playersArray);
  
  assertBlockGotCalled = NO;
  self.model.playersArray = @[];
  XCTAssertFalse(assertBlockGotCalled);
  XCTAssertNotEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.model.playersArray);
  XCTAssertEqualObjects(sample, self.subModel.playersArray);
  
  assertBlockGotCalled = NO;
  self.subModel.playersArray = nil;
  XCTAssert(assertBlockGotCalled);
  XCTAssertNil(self.model.playersArray);
  XCTAssertNil(self.subModel.playersArray);
  
  isAborting = YES;
  assertBlockGotCalled = NO;
  
  self.subModel.playersArray = sample;
  XCTAssert(assertBlockGotCalled);
  XCTAssertNil(self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.model.playersArray);
  

  
}


#pragma mark - Remove Bindings
-(void)testRemoveUniBindingsWithIdentifier; {
  NSString * path = @"playersArray";
  __block BOOL assertBlockGotCalled = NO;
  __block BOOL isAborting = NO;
  NSString * identifier = [self.subModel SH_setBindingUniObserverKeyPath:path toObject:self.model withKeyPath:path transformValueBlock:^id(NSObject *object, NSString *keyPath, id<NSObject> newValue, BOOL *shouldAbort) {
    assertBlockGotCalled = YES;
    *shouldAbort = isAborting;
    return newValue;
  }];
  
  [self.subModel SH_removeAllObserversWithIdentifiers:@[identifier]];
  
  NSArray * sample = @[@(1), @(2)];
  self.subModel.playersArray = sample;
  XCTAssertFalse(assertBlockGotCalled);
  XCTAssertNotEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.model.playersArray);

}

-(void)testRemoveBindingsWithIdentifier; {
  NSString * path = @"playersArray";
  NSArray * identifier = [self.subModel SH_setBindingObserverKeyPath:path toObject:self.model withKeyPath:path];
  
  [self.subModel SH_removeAllObserversWithIdentifiers:@[identifier.firstObject]];
  
  NSArray * sample = @[@(1), @(2)];
  self.subModel.playersArray = sample;

  XCTAssertNotEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.model.playersArray);
  
  
  self.model.playersArray = @[];

  XCTAssertEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.subModel.playersArray);

  [self.model SH_removeAllObserversWithIdentifiers:@[identifier.lastObject]];


  self.model.playersArray = sample;
  XCTAssertNotEqualObjects(self.subModel.playersArray, self.model.playersArray);
  XCTAssertNotEqualObjects(sample, self.subModel.playersArray);

}

-(void)testSetBindingsUniDirectionalWithKeyedEnumerations; {
  
  NSString * path = @"playersDictionary";
  
  
  XCTAssertNil(self.subModel.playersDictionary);
  XCTAssertNil(self.model.playersDictionary);
  XCTAssertNotEqual(self.model, self.subModel);
  
  [self.subModel SH_setBindingUniObserverKeyPath:path toObject:self.model withKeyPath:path transformValueBlock:^id(NSObject *object, NSString *keyPath, id<NSObject> newValue, BOOL *shouldAbort) {
    return newValue;
  }];
  
  
  self.subModel.playersDictionary = @{@"seivan" : @(0)}.mutableCopy;
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  XCTAssertEqualObjects(@{@"seivan" : @(0)}.mutableCopy, self.model.playersDictionary);
  
  [self.subModel.playersDictionary setObject:@(1) forKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
  [self.subModel.playersDictionary removeObjectForKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
  [self.subModel.playersDictionary setObject:@(3) forKey:@"seivan"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
  [self.subModel.playersDictionary setObject:@(99) forKey:@"chris"];
  XCTAssertEqualObjects(self.subModel.playersDictionary, self.model.playersDictionary);
  
}


@end
