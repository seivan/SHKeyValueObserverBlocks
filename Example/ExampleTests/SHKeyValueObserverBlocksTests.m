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

-(void)setUp; {
  [super setUp];
  
}

-(void)tearDown; {
  [super tearDown];
}


#pragma mark - Add Observers
-(void)testSH_addObserverForKeyPaths_withOptions_block; {
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];
  
  STAssertTrue(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
}

#pragma mark - Helpers
-(void)testSH_handleObserverForKeyPath_withChange_context; {
  
}

#pragma mark -Remove Observers
-(void)testSH_removeObserversForKeyPaths_withIdentifiers; {

    

    [self SH_removeObserversForKeyPaths:@[self.backPackArrayKeyPath]
                        withIdentifiers:@[self.firstIdentifier]];
    
    [self SH_removeObserversForKeyPaths:@[self.pocketSetKeyPath]
                        withIdentifiers:@[self.secondIdentifier]];
    
    
    [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
    [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];

  
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForBackPackArray, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.secondBlockDidPassTestForPocketSet, nil);

}

-(void)testSH_removeObserversForKeyPaths; {
  
  [self SH_removeObserversForKeyPaths:@[self.backPackArrayKeyPath]];
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];
  
  
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForPocketSet, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.secondBlockDidPassTestForBackPackArray, nil);

  
}


-(void)testSH_removeObserversWithIdentifiers; {
  
  
  [self SH_removeObserversWithIdentifiers:@[self.firstIdentifier]];
  
  
  [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];
  
  
  STAssertTrue(self.secondBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.secondBlockDidPassTestForBackPackArray, nil);

  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.firstBlockDidPassTestForPocketSet, nil);
  
  
}

-(void)testSH_removeAllObservers; {
  [self SH_removeAllObservers];
  [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];
  
  
  STAssertFalse(self.secondBlockDidPassTestForPocketSet, nil);
  STAssertFalse(self.secondBlockDidPassTestForBackPackArray, nil);
  
  STAssertFalse(self.firstBlockDidPassTestForBackPackArray, nil);
  STAssertFalse(self.firstBlockDidPassTestForPocketSet, nil);
  
}


@end
