//
//  ZGTabMoreSelectedView.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGTabMoreSelectedView.h"

static NSInteger const moreButtonWidth = 40;

@interface ZGTabMoreSelectedView ()

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIButton *moreButton;

@end

@implementation ZGTabMoreSelectedView

+ (instancetype)tabMoreSelectedViewWithTabTitles:(NSArray *)titles
{
    ZGTabMoreSelectedView *tabMoreSelectedView = [[ZGTabMoreSelectedView alloc] initWithTabTitles:titles];
    return tabMoreSelectedView;
}

- (instancetype)initWithTabTitles:(NSArray *)titles
{
    if (self = [super init]) {
        self.titles = titles;
        [self initView];
    }
    return self;
}


- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    
    for (NSString *title in self.titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
    }
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButton = moreButton;
    moreButton.frame = CGRectMake(self.frame.size.width - moreButtonWidth, 0, moreButtonWidth, self.frame.size.height);
    [self addSubview:moreButton];
    
}

@end
