//
//  QMTVViewController.m
//  MineCommonUtils
//
//  Created by BetrayalPromise on 05/28/2018.
//  Copyright (c) 2018 BetrayalPromise. All rights reserved.
//

#import "QMTVViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>

@interface QMTVViewController ()

@end

@implementation QMTVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray * a =  [NSArray findSubClass];
    NSLog(@"%@", a);
    
    NSArray * b =  [NSMutableArray findSubClass];
    NSLog(@"%@", b);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
