//
//  ZGTabMoreCollectionViewCell.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGTabMoreCollectionViewCell.h"

@implementation ZGTabMoreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.tabButton = btn;
        [self.contentView addSubview:self.tabButton];
    }
    
    return self;
}

@end
