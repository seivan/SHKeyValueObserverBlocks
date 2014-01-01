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
  self.model = SHModel.new;
  self.subModel = SHSubModel.new;

  
  
}
-(void)tearDown; {
  [super tearDown];
  self.model = nil;
  self.subModel = nil;
  
}


@end
