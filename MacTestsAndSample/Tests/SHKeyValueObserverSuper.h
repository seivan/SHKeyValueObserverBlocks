//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHTestCaseAdditions.h>
#import "SHKeyValueObserverBlocks.h"

#import "SHModel.h"


@interface SHKeyValueObserverSuper : XCTestCase
@property(nonatomic,strong) SHModel    * model;
@property(nonatomic,strong) SHSubModel * subModel;

@end
