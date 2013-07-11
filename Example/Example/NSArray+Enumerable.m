//
//  NSArray+Enumerable.m
//  Example
//
//  Created by Seivan Heidari on 7/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "NSArray+Enumerable.h"

@implementation NSArray (Enumerable)
-(NSSet *)setRepresentation; {
  return [NSSet setWithArray:self];
}

@end



