//
//  SHKeyValueObserverDeallocationVerifier.h
//  Example
//
//  Created by James Montgomerie on 09/09/2013.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHKeyValueObserverDeallocationVerifier : NSObject

- (id)initWithDeallocationFlag:(BOOL *)deallocationFlag;

@property (nonatomic, strong) NSString *testProperty;

@end
