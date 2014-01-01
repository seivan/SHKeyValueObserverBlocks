//
//  SHModel.m
//  Sample
//
//  Created by Seivan Heidari on 2013-12-27.
//  Copyright (c) 2013 Seivan. All rights reserved.
//

#import "SHModel.h"


@implementation SHKeyValueObserverTestManager
@end


@implementation SHKeyValueObserverDeallocationSuperVerifier


-(void)dealloc;{
  self.testManager.isSuperDealloced = YES;
}
@end


@implementation SHKeyValueObserverDeallocationSubVerifier


-(void)dealloc; {
  self.testManager.isSubDealloced = YES;
}

@end



@implementation SHModel
-(void)dealloc; {
  NSLog(@"DEALLOC!");
}
@end

@implementation SHSubModel
-(void)dealloc; {
  NSLog(@"SUBMODEL DEALLOC!");
}
@end