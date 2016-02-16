//
//  ZGTabMoreSelectedView.h
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGTabMoreSelectedView;

@protocol ZGTabMoreSelectedViewDelegate <NSObject>

@optional
- (void)tabMoreSelectedView:(ZGTabMoreSelectedView *)tabMoreSelectedView didSelectTabButton:(UIButton *)tabButton didSelectAtIndex:(NSInteger)index;
- (void)tabMoreSelectedView:(ZGTabMoreSelectedView *)tabMoreSelectedView didSelectMoreButton:(UIButton *)moreButton;
@end

@interface ZGTabMoreSelectedView : UIView

+ (instancetype)tabMoreSelectedViewWithTabTitles:(NSArray *)titles frame:(CGRect)frame;
- (instancetype)initWithTabTitles:(NSArray *)titles frame:(CGRect)frame;

@property (nonatomic, weak) id <ZGTabMoreSelectedViewDelegate> delegate;

@end
