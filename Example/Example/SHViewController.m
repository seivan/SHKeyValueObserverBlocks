//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "NSArray+Enumerable.h"

#import "SHViewController.h"

@interface SHViewController ()
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;

@end

@implementation SHViewController

-(void)viewDidLoad;{
  [super viewDidLoad];
  [self SH_performSegueWithIdentifier:@"push" andPrepareForSegueBlock:nil];

}


-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{

}


@end
