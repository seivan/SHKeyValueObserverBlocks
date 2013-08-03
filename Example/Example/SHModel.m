//
//  SHModel.m
//  Example
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHModel.h"

@implementation SHBackPack
-(instancetype)init; {
  self = [super init];
  if(self) {
    self.items = [@[] mutableCopy];
  }
  return self;
}

@end

@implementation SHPocket

-(instancetype)init; {
  self = [super init];
  if(self) {
    self.items = [NSMutableSet set];
  }
  return self;
}

@end

@implementation SHPlayer
-(instancetype)init; {
  self = [super init];
  if(self) {
    self.pocketSet   = SHPocket.new;
    self.backPackArray = SHBackPack.new;
  }
  return self;
}
@end

