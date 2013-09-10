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



@interface SHKeyValueObserverSuper : SenTestCase
@property(nonatomic,strong) SHPlayer * player;

@property(nonatomic,assign) BOOL firstBlockDidPassTestForBackPackArray;
@property(nonatomic,assign) BOOL firstBlockDidPassTestForPocketSet;

@property(nonatomic,assign) BOOL secondBlockDidPassTestForBackPackArray;
@property(nonatomic,assign) BOOL secondBlockDidPassTestForPocketSet;


@property(nonatomic,strong) NSString * backPackArrayKeyPath;
@property(nonatomic,strong) NSString * pocketSetKeyPath;

@property(nonatomic,strong) NSString * firstIdentifier;
@property(nonatomic,strong) NSString * secondIdentifier;

@end
