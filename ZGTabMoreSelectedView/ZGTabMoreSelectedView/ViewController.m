//
//  ViewController.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGTabMoreSelectedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titles = @[@"中国",@"韩国",@"泰国"];
    ZGTabMoreSelectedView *tabMoreView = [[ZGTabMoreSelectedView alloc] initWithTabTitles:titles];
    
    [self.view addSubview:tabMoreView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
