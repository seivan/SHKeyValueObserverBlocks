//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHKeyValueObserverSuper.h"

@interface SHKeyValueObserverHelpersTests : SHKeyValueObserverSuper

@end


@implementation SHKeyValueObserverHelpersTests

-(void)setUp; {
  [super setUp];
}


#pragma mark - Helpers
-(void)testSH_handleObserverForKeyPath_withChange_context; {
  [[self mutableArrayValueForKeyPath:self.backPackArrayKeyPath] addObject:@(1)];
  [[self mutableSetValueForKeyPath:self.pocketSetKeyPath] addObject:@(1)];
  
  
  STAssertTrue(self.firstBlockDidPassTestForPocketSet, nil);
  STAssertTrue(self.firstBlockDidPassTestForBackPackArray, nil);

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context; {
  if([keyPath isEqualToString:self.backPackArrayKeyPath])
    self.firstBlockDidPassTestForBackPackArray = [self SH_handleObserverForKeyPath:keyPath withChange:change context:context];
  if([keyPath isEqualToString:self.pocketSetKeyPath])
    self.firstBlockDidPassTestForPocketSet     = [self SH_handleObserverForKeyPath:keyPath withChange:change context:context];
}

@end
