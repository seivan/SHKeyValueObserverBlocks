//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"

@interface SHKeyValueObserverConfigurationTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverConfigurationTests

-(void)setUp; {
  [super setUp];
  [self.player SH_addObserverForKeyPaths:@[@"backPackArray.items"] withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    
  }];
}


#pragma mark - Configuration

-(void)testSH_isAutoRemovingObserversIsDefaultTrue; {
  STAssertTrue([NSObject SH_isAutoRemovingObservers], nil);

}

-(void)testSH_setAutoRemovingObservers; {
  [NSObject SH_setAutoRemovingObservers:NO];
  STAssertFalse([NSObject SH_isAutoRemovingObservers], nil);
  [NSObject SH_setAutoRemovingObservers:YES];
  [self testSH_isAutoRemovingObserversIsDefaultTrue];
}

-(void)testAutoRemovingObserverYES; {
  [NSObject SH_setAutoRemovingObservers:YES];
  STAssertNoThrow([self setPlayer:nil], nil);
}



-(void)testAutoRemovingObserverNO; {
  [NSObject SH_setAutoRemovingObservers:NO];
//  STAssertThrows([self setPlayer:nil], nil);

  
  
  
  
  
}

@end
