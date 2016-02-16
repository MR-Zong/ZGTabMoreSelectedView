//
//  ViewController.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGTabMoreSelectedView.h"

@interface ViewController () <ZGTabMoreSelectedViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titles = @[@"中国",@"沙特阿拉伯",@"泰国",@"马来西亚",@"印度尼西亚",@"俄罗斯",@"美国",@"德国",@"委内瑞拉",@"阿根廷",@"哈萨克斯坦"];
    ZGTabMoreSelectedView *tabMoreView = [[ZGTabMoreSelectedView alloc] initWithTabTitles:titles frame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    tabMoreView.backgroundColor = [UIColor redColor];
    
    tabMoreView.delegate = self;
    [self.view addSubview:tabMoreView];
}



#pragma mark - <ZGTabMoreSelectedViewDelegate>
- (void)tabMoreSelectedView:(ZGTabMoreSelectedView *)tabMoreSelectedView didSelectTabButton:(UIButton *)tabButton didSelectAtIndex:(NSInteger)index
{
    NSLog(@"index %zd",index);
}

- (void)tabMoreSelectedView:(ZGTabMoreSelectedView *)tabMoreSelectedView didSelectMoreButton:(UIButton *)moreButton
{
    NSLog(@"didSelectMoreButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
