//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"


@interface SHKeyValueObserverTestManager : NSObject
@property(nonatomic,assign) BOOL isSuperDealloced;
@property(nonatomic,assign) BOOL isSubDealloced;
@end

@implementation SHKeyValueObserverTestManager
@end

@interface SHKeyValueObserverDeallocationSuperVerifier : NSObject
@property(nonatomic, strong) SHKeyValueObserverTestManager *testManager;
@property(nonatomic,strong) NSString *testProperty;
@end

@implementation SHKeyValueObserverDeallocationSuperVerifier


-(void)dealloc;{
  self.testManager.isSuperDealloced = YES;
}
@end

@interface SHKeyValueObserverDeallocationSubVerifier : SHKeyValueObserverDeallocationSuperVerifier
@end

@implementation SHKeyValueObserverDeallocationSubVerifier


-(void)dealloc; {
  self.testManager.isSubDealloced = YES;
}

@end


@interface SHKeyValueObserverDeallocationTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverDeallocationTests

-(void)testOriginalDeallocIsCalled; {
  SHKeyValueObserverTestManager *testManager = [[SHKeyValueObserverTestManager alloc] init];
  
  STAssertFalse(testManager.isSuperDealloced, nil);
  STAssertFalse(testManager.isSubDealloced, nil);
  @autoreleasepool {
    SHKeyValueObserverDeallocationSubVerifier * v = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    v.testManager = testManager;
    [v SH_addObserverForKeyPaths:@[@"testProperty"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      
    }];
  }
  STAssertTrue(testManager.isSuperDealloced, nil);
  STAssertTrue(testManager.isSubDealloced, nil);
}


-(void)testDeallocOrderingWhenSubclassAndSuperclassObservedIndependently; {
  SHKeyValueObserverTestManager *superTestManager = [[SHKeyValueObserverTestManager alloc] init];
  SHKeyValueObserverTestManager *subTestManager = [[SHKeyValueObserverTestManager alloc] init];
  
  STAssertFalse(superTestManager.isSuperDealloced, nil);
  STAssertFalse(subTestManager.isSuperDealloced, nil);
  STAssertFalse(subTestManager.isSubDealloced, nil);
  @autoreleasepool {
    SHKeyValueObserverDeallocationSuperVerifier * superVerifier = [[SHKeyValueObserverDeallocationSuperVerifier alloc] init];
    superVerifier.testManager = superTestManager;
    [superVerifier SH_addObserverForKeyPaths:@[@"testProperty"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      
    }];
    
    superVerifier.testManager = subTestManager;
    SHKeyValueObserverDeallocationSubVerifier * subVerifier = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    [subVerifier SH_addObserverForKeyPaths:@[@"testProperty"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      
    }];
  }
  STAssertTrue(superTestManager.isSuperDealloced, nil);
  STAssertTrue(subTestManager.isSuperDealloced, nil);
  STAssertTrue(subTestManager.isSubDealloced, nil);
}

@end
