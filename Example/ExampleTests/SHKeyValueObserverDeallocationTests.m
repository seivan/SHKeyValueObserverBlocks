//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"


@interface SHKeyValueObserverTestManager : NSObject
+(instancetype)sharedManager;
@property(nonatomic,assign) BOOL isSuperDealloced;
@property(nonatomic,assign) BOOL isSubDealloced;
@end

@implementation SHKeyValueObserverTestManager
-(instancetype)init; {
  self = [super init];
  if(self) {
    self.isSubDealloced   = NO;
    self.isSuperDealloced = NO;
  }
  return self;
}

+(instancetype)sharedManager; {
  static SHKeyValueObserverTestManager * manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager =  [[SHKeyValueObserverTestManager alloc] init];
  });
  return manager;
}


@end

@interface SHKeyValueObserverDeallocationSuperVerifier : NSObject

@end

@implementation SHKeyValueObserverDeallocationSuperVerifier


-(void)dealloc;{
  [SHKeyValueObserverTestManager sharedManager].isSuperDealloced = YES;
}
@end

@interface SHKeyValueObserverDeallocationSubVerifier : SHKeyValueObserverDeallocationSuperVerifier
@property(nonatomic,strong) NSString *testProperty;
@end

@implementation SHKeyValueObserverDeallocationSubVerifier


-(void)dealloc; {
  [SHKeyValueObserverTestManager sharedManager].isSubDealloced = YES;
}

@end


@interface SHKeyValueObserverDeallocationTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverDeallocationTests

-(void)testOriginalDeallocIsCalled; {
  STAssertFalse([SHKeyValueObserverTestManager sharedManager].isSuperDealloced, nil);
  STAssertFalse([SHKeyValueObserverTestManager sharedManager].isSubDealloced, nil);
  @autoreleasepool {
    SHKeyValueObserverDeallocationSubVerifier * v = [[SHKeyValueObserverDeallocationSubVerifier alloc] init];
    [v SH_addObserverForKeyPaths:@[@"testProperty"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      
    }];
  }
  STAssertTrue([SHKeyValueObserverTestManager sharedManager].isSuperDealloced, nil);
  STAssertTrue([SHKeyValueObserverTestManager sharedManager].isSubDealloced, nil);


  
}
@end
