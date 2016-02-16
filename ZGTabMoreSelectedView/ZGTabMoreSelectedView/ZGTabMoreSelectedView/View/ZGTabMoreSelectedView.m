//
//  ZGTabMoreSelectedView.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGTabMoreSelectedView.h"

static NSInteger const kMoreButtonWidth = 40;
static CGFloat const kMinTabButtonWidth = 60;

@interface ZGTabMoreSelectedView ()

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *moreContentView;

@property (nonatomic, weak) UIButton *moreButton;

@property (nonatomic, assign) NSInteger moreButtonColumn;

@property (nonatomic, assign) CGFloat moreButtonHeight;

@property (nonatomic, assign) CGFloat moreButtonWidth;

@property (nonatomic, assign) CGFloat needMoreHeight;


@end

@implementation ZGTabMoreSelectedView

+ (instancetype)tabMoreSelectedViewWithTabTitles:(NSArray *)titles frame:(CGRect)frame
{
    ZGTabMoreSelectedView *tabMoreSelectedView = [[ZGTabMoreSelectedView alloc] initWithTabTitles:titles frame:frame];
    return tabMoreSelectedView;
}

- (instancetype)initWithTabTitles:(NSArray *)titles frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.moreButtonColumn = 5;
        self.moreButtonHeight = 23;
        self.moreButtonWidth = 40;
        [self initView];
    }
    return self;
}


- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 0, self.bounds.size.width - kMoreButtonWidth, self.bounds.size.height);
    [self addSubview:scrollView];
    
    CGFloat tabButtonWidth = self.scrollView.frame.size.width / self.titles.count;
    if (tabButtonWidth < kMinTabButtonWidth) {
        tabButtonWidth = kMinTabButtonWidth;
    }
    for (int i=0 ; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * tabButtonWidth, 0, tabButtonWidth, self.scrollView.frame.size.height);
        [btn addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    self.scrollView.contentSize = CGSizeMake(self.titles.count * tabButtonWidth , 0);
    
    // moreButton
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButton = moreButton;
    moreButton.frame = CGRectMake(self.frame.size.width - kMoreButtonWidth, 0, kMoreButtonWidth, self.frame.size.height);
    moreButton.backgroundColor = [UIColor greenColor];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
    
    // moreContentView
    UIView *moreContentView = [[UIView alloc] init];
    self.moreContentView = moreContentView;
    NSInteger row = 0;
    NSInteger col = 0;
    CGFloat rowMargin = 10;
    CGFloat colMargin = rowMargin;
    
    for (int i=0 ; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        row = i / self.moreButtonColumn;
        col = i % self.moreButtonColumn;
        btn.frame = CGRectMake(col * (self.moreButtonWidth + colMargin), row * (self.moreButtonHeight + rowMargin) + self.bounds.size.height, self.moreButtonWidth, self.moreButtonHeight);
        
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.moreContentView addSubview:btn];
    }
    self.needMoreHeight = (row+1) * self.moreButtonHeight + row * rowMargin;
    moreContentView.backgroundColor = [UIColor redColor];
    
}

#pragma mark - buttonClick
- (void)tabButtonClick:(UIButton *)tabButton
{
    
    [UIView animateWithDuration:.1 animations:^{
        
        if (tabButton.frame.origin.x>self.scrollView.frame.size.width/2) {
            //当前按钮位置大于屏幕一半
            if (self.scrollView.contentSize.width-tabButton.frame.origin.x-tabButton.frame.size.width/2>self.scrollView.frame.size.width/2) {
                //当前按钮后往右边可滚动的位置大于一半
                self.scrollView.contentOffset = CGPointMake(tabButton.frame.origin.x-self.scrollView.frame.size.width/2, 0);
            }else{
                //当前按钮后往右边可滚动的位置小于一半 显示的滚动内容
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width-self.scrollView.frame.size.width, 0);
            }
        }else{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
        
    }];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabMoreSelectedView:didSelectTabButton:didSelectAtIndex:)]) {
        [self.delegate tabMoreSelectedView:self didSelectTabButton:tabButton didSelectAtIndex:tabButton.tag];
    }
}

- (void)moreButtonClick:(UIButton *)moreButton
{
    if (self.moreContentView.window) {
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height -= self.needMoreHeight;
        self.frame = tmpFrame;
        [self.moreContentView removeFromSuperview];
    }else {
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height += self.needMoreHeight;
        self.frame = tmpFrame;
        self.moreContentView.frame = self.bounds;
        [self insertSubview:self.moreContentView belowSubview:self.moreButton];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabMoreSelectedView:didSelectMoreButton:)]) {
        [self.delegate tabMoreSelectedView:self didSelectMoreButton:moreButton];
    }
}

@end
