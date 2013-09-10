//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHModel.h"


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
  
  NSArray * keyPaths = @[@"players"];
  NSString * identifier = [self SH_addObserverForKeyPaths:keyPaths
                                                    block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier: %@ - %@",change, keyPath);
  }];
  [self.players addObject:self.player];
  
  keyPaths = @[@"player.pocketSet.items",@"player.backPackArray.items"];
  [self SH_addObserverForKeyPaths:keyPaths
                            block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier2: %@ - %@",change,keyPath);
  }];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
    [[self mutableArrayValueForKeyPath:@"player.backPackArray.items"] addObject:@"potion"];
    [[self mutableSetValueForKeyPath:@"player.pocketSet.items"] addObject:@"lighter"];
    [[self mutableArrayValueForKey:@"players"] addObject:SHPlayer.new];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [self SH_removeObserversForKeyPaths:@[@"players"]
                          withIdentifiers:@[identifier]
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

-(void)dealloc; {
    
}

@end
