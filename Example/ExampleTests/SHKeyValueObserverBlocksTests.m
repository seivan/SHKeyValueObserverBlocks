//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverBlocks.h"
#import "SHModel.h"
#import <SenTestingKit/SenTestingKit.h>


@interface SHKeyValueObserverBlocksTests : SenTestCase
@property(nonatomic,strong) SHPlayer * player;

@property(nonatomic,assign) BOOL firstBlockDidPassTestForBackPackArray;
@property(nonatomic,assign) BOOL firstBlockDidPassTestForPocketSet;

@property(nonatomic,assign) BOOL secondBlockDidPassTestForBackPackArray;
@property(nonatomic,assign) BOOL secondBlockDidPassTestForPocketSet;


@property(nonatomic,strong) NSString * backPackArray;
@property(nonatomic,strong) NSString * pocketSet;

@property(nonatomic,strong) NSString * firstIdentifier;
@property(nonatomic,strong) NSString * secondIdentifier;

@end


@implementation SHKeyValueObserverBlocksTests

-(void)setUp; {
  [super setUp];
  self.player = SHPlayer.new;
  
  self.firstBlockDidPassTestForBackPackArray = NO;
  self.firstBlockDidPassTestForPocketSet     = NO;
  
  self.secondBlockDidPassTestForBackPackArray = NO;
  self.secondBlockDidPassTestForPocketSet     = NO;
  
  
  self.backPackArray  = @"player.backPackArray.items";
  self.pocketSet      = @"player.pocketSet.items";
  
  self.firstIdentifier = [self SH_addObserverForKeyPaths:@[self.backPackArray, self.pocketSet] withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    STAssertEqualObjects(self, weakSelf, nil);
    STAssertNotNil(keyPath, nil);
    STAssertNotNil(change, nil);
    if([keyPath isEqualToString:self.backPackArray])
      self.firstBlockDidPassTestForBackPackArray = YES;
    if([keyPath isEqualToString:self.pocketSet])
      self.firstBlockDidPassTestForPocketSet = YES;
  }];
  
  self.secondIdentifier = [self SH_addObserverForKeyPaths:@[self.backPackArray, self.pocketSet] withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    STAssertEqualObjects(self, weakSelf, nil);
    STAssertNotNil(keyPath, nil);
    STAssertNotNil(change, nil);
    if([keyPath isEqualToString:self.backPackArray])
      self.secondBlockDidPassTestForBackPackArray = YES;
    if([keyPath isEqualToString:self.pocketSet])
      self.secondBlockDidPassTestForPocketSet = YES;
  }];


  
  
}
-(void)tearDown; {
  [super tearDown];
}

-(void)testSH_addObserverForKeyPaths_withOptions_block; {
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArray] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSet] addObject:@(1)];
  
  STAssertTrue(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
}

-(void)testSH_removeObserversForKeyPaths_withIdentifiers; {

    

    [self SH_removeObserversForKeyPaths:@[self.backPackArray]
                        withIdentifiers:@[self.firstIdentifier]];
    
    [self SH_removeObserversForKeyPaths:@[self.pocketSet]
                        withIdentifiers:@[self.secondIdentifier]];
    
    
    [[self mutableArrayValueForKeyPath:self.backPackArray] addObject:@(1)];
    [[self mutableSetValueForKeyPath:self.pocketSet] addObject:@(1)];

  
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForBackPackArray, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.secondBlockDidPassTestForPocketSet, nil);

}

-(void)testSH_removeObserversForKeyPaths; {
  
  
  
  
  
  [self SH_removeObserversForKeyPaths:@[self.backPackArray]];
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArray] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSet] addObject:@(1)];
  
  
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForPocketSet, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.secondBlockDidPassTestForBackPackArray, nil);

  
}


-(void)testSH_removeObserversWithIdentifiers; {
  
  
  [self SH_removeObserversWithIdentifiers:@[self.firstIdentifier]];
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArray] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSet] addObject:@(1)];
  
  
  STAssertTrue(self.secondBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForBackPackArray, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.firstBlockDidPassTestForPocketSet, nil);
  
  
}

@end
