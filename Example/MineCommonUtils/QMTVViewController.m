//
//  QMTVViewController.m
//  MineCommonUtils
//
//  Created by BetrayalPromise on 05/28/2018.
//  Copyright (c) 2018 BetrayalPromise. All rights reserved.
//

#import "QMTVViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <RSSwizzle/RSSwizzle.h>

@interface QMTVViewController ()

@end

@implementation QMTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray * a =  [NSArray findSubClass];
    NSLog(@"%@", a);
    
    NSArray * b =  [NSMutableArray findSubClass];
    NSLog(@"%@", b);
    
    UIView * v = [[[UIView structureView] objectThen:^(UIView *_Nonnull source) {
        source.backgroundColor = [UIColor redColor];
        source.frame = CGRectMake(100, 100, 100, 100);
    }] attachTo:self.view];
    
    UIButton * button = [[[UIButton structureView] objectThen:^(UIButton *_Nonnull source) {
        source.backgroundColor = [UIColor redColor];
        source.frame = CGRectMake(-50,-50, 50, 50);
        [source addTarget:self action:@selector(aaa) forControlEvents:(UIControlEventTouchUpInside)];
        source.ableRespose = YES;
    }] attachTo:v];
    NSLog(@"%@", button);
    GNUString(@"A").attributedText;
    
    widgetAdaptive(20, ^(LogicSize *s) {
        s->size_320 = 1.0;
        s->size_375 = 1.0;
        s->size_414 = 1.5;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)aaa {
    NSLog(@"AAAA");
}

@end
