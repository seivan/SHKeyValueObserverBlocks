//
//  SHAppDelegate.m
//  OSX-Example
//
//  Created by Seivan Heidari on 7/9/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHKeyValueObserverBlocks.h"

@interface SHAppDelegate ()
@property(nonatomic,strong) NSMutableArray * mutableArray;
@property(nonatomic,strong) NSMutableSet   * mutableSet;
@end

@implementation SHAppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;{
  self.mutableArray     = [@[] mutableCopy];
  self.mutableSet       = [NSMutableSet set];
  
  //  [self addObserver:self forKeyPath:@"mutableArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior context:NULL];
  
  NSString * identifier = [self SH_addObserverForKeyPaths:@[@"mutableArray",@"mutableSet"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier: %@ - %@",change, keyPath);
  }];
  
  NSString * identifier2 = [self SH_addObserverForKeyPaths:@[@"mutableArray",@"mutableSet"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier2: %@ - %@",change,keyPath);
  }];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self SH_removeObserversForKeyPaths:@[@"mutableArray", @"mutableSet"] withIdentifiers:@[identifier]];
    [[self mutableArrayValueForKey:@"mutableArray"] addObject:@"DAAAAAAAAMNG"];
    [self SH_removeObserversWithIdentifiers:@[identifier2]];
    //self.mutableArray = @[].mutableCopy;
  });

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;  {
  if([self SH_handleObserverForKeyPath:keyPath withChange:change context:context])
    NSLog(@"TAKEN CARE OF BY BLOCK");
  else
    NSLog(@"Take care of here!");
  
}


@end
