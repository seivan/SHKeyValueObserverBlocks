//
//  SHKeyValueObserverDeallocationVerifier.m
//  Example
//
//  Created by James Montgomerie on 09/09/2013.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHKeyValueObserverDeallocationVerifier.h"

@implementation SHKeyValueObserverDeallocationVerifier {
    BOOL *_deallocationFlag;
}

- (id)initWithDeallocationFlag:(BOOL *)deallocationFlag
{
    self = [super init];
    if(self) {
        _deallocationFlag = deallocationFlag;
        *deallocationFlag = NO;
    }
    return self;
}

- (void)dealloc
{
    *_deallocationFlag = YES;
}

@end
