//
//  LBViewController.m
//  LBFinder
//
//  Created by 294842586@qq.com on 01/11/2018.
//  Copyright (c) 2018 294842586@qq.com. All rights reserved.
//

#import "LBViewController.h"
#import "LBFinderVC.h"
@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 80);
    btn.center = self.view.center;
    [btn setTitle:@"Go to Finder" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTintColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction:(UIButton *)sender {
    LBFinderVC *vc = [LBFinderVC instanceWithPath:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
