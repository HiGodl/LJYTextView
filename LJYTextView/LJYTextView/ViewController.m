//
//  ViewController.m
//  LJYTextView
//
//  Created by jyLu on 16/3/29.
//  Copyright © 2016年 jyLu. All rights reserved.
//

#import "ViewController.h"
#import "LJYTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LJYTextView *textView = [[LJYTextView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
    textView.placeHolder = @"aaaaa";
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
