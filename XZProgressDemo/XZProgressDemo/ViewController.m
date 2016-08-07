//
//  ViewController.m
//  XZProgressDemo
//
//  Created by 徐章 on 16/8/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZProgressView.h"

@interface ViewController ()
{

    XZProgressView *_progressView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[XZProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _progressView.center = self.view.center;
    _progressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_progressView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    button.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(testBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testBtn_Pressed{
    _progressView.percent = 48.8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
