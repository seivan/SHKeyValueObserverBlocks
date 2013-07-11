//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "NSArray+Enumerable.h"

@interface SHBackPack : NSObject
@property(nonatomic,strong) NSMutableArray * items;
@end

@implementation SHBackPack
-(instancetype)init; {
  self = [super init];
  if(self) {
    self.items = [@[] mutableCopy];
  }
  return self;
}

@end

@interface SHPocket : NSObject
@property(nonatomic,strong) NSMutableSet * items;
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


@interface SHPlayer : NSObject
@property(nonatomic,strong) SHBackPack * backPack;
@property(nonatomic,strong) SHPocket   * pocket;
@end

@implementation SHPlayer
-(instancetype)init; {
  self = [super init];
  if(self) {
    self.pocket   = SHPocket.new;
    self.backPack = SHBackPack.new;
  }
  return self;
}
@end

@interface SHSecondViewController ()
-(IBAction)tapProgUnwind:(id)sender;
@property(nonatomic,strong) NSMutableArray * players;
@property(nonatomic,strong) SHPlayer       * player;
-(void)runObservers;
@end

@implementation SHSecondViewController

-(void)runObservers; {

  self.players = [@[] mutableCopy];
  self.player  = SHPlayer.new;
  
  NSSet * keyPaths = @[@"players"].setRepresentation;
  NSString * identifier = [self SH_addObserverForKeyPaths:keyPaths
                                                    block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier: %@ - %@",change, keyPath);
  }];
  [self.players addObject:self.player];
  
  keyPaths = @[@"player.pocket.items",@"player.backPack.items"].setRepresentation;
  [self SH_addObserverForKeyPaths:keyPaths
                            block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier2: %@ - %@",change,keyPath);
  }];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
    [[self mutableArrayValueForKeyPath:@"player.backPack.items"] addObject:@"potion"];
    [[self mutableSetValueForKeyPath:@"player.pocket.items"] addObject:@"lighter"];
    [[self mutableArrayValueForKey:@"players"] addObject:SHPlayer.new];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [self SH_removeObserversForKeyPaths:@[@"players"].setRepresentation
                          withIdentifiers:@[identifier].setRepresentation
       ];
      
    });
    
  });
  
  
  
}




-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self runObservers];
  
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;  {
  if([self SH_handleObserverForKeyPath:keyPath withChange:change context:context])
    NSLog(@"TAKEN CARE OF BY BLOCK");
  else
    NSLog(@"Take care of here!");
    
}

-(IBAction)tapProgUnwind:(id)sender; {
  //[self performSegueWithIdentifier:@"unwinder" sender:self];
  [self SH_performSegueWithIdentifier:@"unwinder" withUserInfo:@{@"date" : [NSDate date]}];
}

@end
