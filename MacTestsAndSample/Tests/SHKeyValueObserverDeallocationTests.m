//
//SHKeyValueObserverBlocksDeallocTests.m
//Sample
//
//Created by Seivan Heidari on 2013-12-26.
//Copyright (c) 2013 Seivan. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"


@interface SHKeyValueObserverDeallocationTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverDeallocationTests

-(void)testOriginalDeallocIsCalled; {
  SHKeyValueObserverTestManager *testManager = [[SHKeyValueObserverTestManager alloc] init];
  
  XCTAssertFalse(testManager.isSuperDealloced);
  XCTAssertFalse(testManager.isSubDealloced);
  @autoreleasepool {
    SHKeyValueObserverDeallocationSubVerifier * v = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    v.testManager = testManager;
    
    
    [v SH_addObserverForKeyPaths:@[@"testProperty"] withOptions:kNilOptions
                           block:^(NSString *keyPath, NSDictionary *change) {
                             
                           }];
  }
  XCTAssert(testManager.isSuperDealloced);
  XCTAssert(testManager.isSubDealloced);
}


-(void)testDeallocOrderingWhenSubclassAndSuperclassObservedIndependently; {
  SHKeyValueObserverTestManager * superTestManager = [[SHKeyValueObserverTestManager alloc] init];
  SHKeyValueObserverTestManager * subTestManager = [[SHKeyValueObserverTestManager alloc] init];
  
  XCTAssertFalse(superTestManager.isSuperDealloced);
  XCTAssertFalse(subTestManager.isSuperDealloced);
  XCTAssertFalse(subTestManager.isSubDealloced);
  @autoreleasepool {
    SHKeyValueObserverDeallocationSuperVerifier * superVerifier = [[SHKeyValueObserverDeallocationSuperVerifier alloc] init];
    superVerifier.testManager = superTestManager;
    
    [superVerifier SH_addObserverForKeyPaths:@[@"testProperty"] withOptions:kNilOptions
                                       block:^(NSString *keyPath, NSDictionary *change) {
                                         
                                       }];
    

    SHKeyValueObserverDeallocationSubVerifier * subVerifier = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    subVerifier.testManager = subTestManager;
    [subVerifier SH_addObserverForKeyPaths:@[@"testProperty"] withOptions:kNilOptions
                                     block:^(NSString *keyPath, NSDictionary *change) {
                                       
                                     }];
  }
  
  
  XCTAssert(superTestManager.isSuperDealloced);
  XCTAssert(subTestManager.isSuperDealloced);
  XCTAssert(subTestManager.isSubDealloced);
}

-(void)testDeallocWithUniBindersWithBlock; {
  SHKeyValueObserverTestManager * superTestManager = [[SHKeyValueObserverTestManager alloc] init];
  SHKeyValueObserverTestManager * subTestManager = [[SHKeyValueObserverTestManager alloc] init];

  @autoreleasepool {
  SHKeyValueObserverDeallocationSuperVerifier * superVerifier = [[SHKeyValueObserverDeallocationSuperVerifier alloc] init];
  SHKeyValueObserverDeallocationSubVerifier * subVerifier = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
  superVerifier.testManager = superTestManager;
  subVerifier.testManager = subTestManager;

  XCTAssertFalse(superVerifier.testManager.isSuperDealloced);
  XCTAssertFalse(superVerifier.testManager.isSubDealloced);

  XCTAssertFalse(subVerifier.testManager.isSuperDealloced);
  XCTAssertFalse(subVerifier.testManager.isSubDealloced);

  [subVerifier SH_setBindingUniObserverKeyPath:@"testProperty" toObject:superVerifier withKeyPath:@"testProperty" transformValueBlock:^id(NSObject *object, NSString *keyPath, NSObject * newValue, BOOL *shouldAbort) {
    return newValue;
  }];
  NSString * assignment= @"Testing my string";
  subVerifier.testProperty = assignment;
  XCTAssertEqualObjects(superVerifier.testProperty, assignment);
  }


  XCTAssert(superTestManager.isSuperDealloced);
  XCTAssertFalse(superTestManager.isSubDealloced);


  XCTAssert(subTestManager.isSuperDealloced);
  XCTAssert(subTestManager.isSubDealloced);

  

  
}

-(void)testDeallocWithBinders; {
  SHKeyValueObserverTestManager * superTestManager = [[SHKeyValueObserverTestManager alloc] init];
  SHKeyValueObserverTestManager * subTestManager = [[SHKeyValueObserverTestManager alloc] init];
  
  @autoreleasepool {
    SHKeyValueObserverDeallocationSuperVerifier * superVerifier = [[SHKeyValueObserverDeallocationSuperVerifier alloc] init];
    SHKeyValueObserverDeallocationSubVerifier * subVerifier = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    superVerifier.testManager = superTestManager;
    subVerifier.testManager = subTestManager;
    
    XCTAssertFalse(superVerifier.testManager.isSuperDealloced);
    XCTAssertFalse(superVerifier.testManager.isSubDealloced);
    
    XCTAssertFalse(subVerifier.testManager.isSuperDealloced);
    XCTAssertFalse(subVerifier.testManager.isSubDealloced);
    
    [subVerifier SH_setBindingObserverKeyPath:@"testProperty" toObject:superVerifier withKeyPath:@"testProperty"];
    NSString * assignment= @"Testing my string";
    subVerifier.testProperty = assignment;
    XCTAssertEqualObjects(superVerifier.testProperty, assignment);
  }
  
  
  XCTAssert(superTestManager.isSuperDealloced);
  XCTAssertFalse(superTestManager.isSubDealloced);
  
  
  XCTAssert(subTestManager.isSuperDealloced);
  XCTAssert(subTestManager.isSubDealloced);
  
}




@end