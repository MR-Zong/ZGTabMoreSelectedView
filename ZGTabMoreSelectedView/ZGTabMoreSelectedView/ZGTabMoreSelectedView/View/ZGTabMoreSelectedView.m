//
//  ZGTabMoreSelectedView.m
//  ZGTabMoreSelectedView
//
//  Created by Zong on 16/2/16.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGTabMoreSelectedView.h"
#import "ZGTabMoreCollectionViewCell.h"
#import "ZGTabMoreFlowLayout.h"

static NSInteger const kMoreButtonWidth = 40;

@interface ZGTabMoreSelectedView () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *moreContentView;

@property (nonatomic, weak) UIButton *moreButton;

@property (nonatomic, assign) NSInteger moreButtonColumn;

@property (nonatomic, assign) CGFloat moreButtonHeight;

@property (nonatomic, assign) CGFloat moreButtonWidth;

@property (nonatomic, weak) UICollectionView *collectionView;


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
    
    CGFloat sumOfWidth = 0.0;
    for (int i=0 ; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        
        CGFloat tabButtonWidth = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}].width + 6;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        NSAttributedString *attributeTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        [btn setAttributedTitle:attributeTitle forState:UIControlStateNormal];
        btn.frame = CGRectMake(sumOfWidth, 0, tabButtonWidth, self.scrollView.frame.size.height);
        [btn addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        sumOfWidth += tabButtonWidth;
    }
    self.scrollView.contentSize = CGSizeMake(sumOfWidth , 0);
    
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
    
    ZGTabMoreFlowLayout *flowLayout = [[ZGTabMoreFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 100) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[ZGTabMoreCollectionViewCell class] forCellWithReuseIdentifier:@"ZGTabMoreCell"];
    collectionView.backgroundColor = [UIColor grayColor];
    
    [self.moreContentView addSubview:collectionView];
    moreContentView.backgroundColor = [UIColor redColor];
    
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGTabMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZGTabMoreCell" forIndexPath:indexPath];
    
    [cell.tabButton setTitle:self.titles[indexPath.item] forState:UIControlStateNormal];
    cell.tabButton.tag = indexPath.item;
    [cell.tabButton addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.tabButton sizeToFit];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titles[indexPath.item];
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    textSize.width += 10;
    textSize.height += 10;
    return textSize;
}

#pragma mark - buttonClick
- (void)tabButtonClick:(UIButton *)tabButton
{
    
    [UIView animateWithDuration:.1 animations:^{
        
        if (tabButton.frame.origin.x>self.scrollView.frame.size.width/2) {
            //当前按钮位置大于屏幕一半
            
            if (self.scrollView.contentSize.width-tabButton.frame.origin.x-tabButton.frame.size.width/2>self.scrollView.frame.size.width/2) {
                //当前按钮后往右边可滚动的位置大于一半
                
                // 如果剩下的内容不可以整个显示出来就把当前按钮的x与scrollview.frame的中点对齐
                self.scrollView.contentOffset = CGPointMake(tabButton.frame.origin.x-self.scrollView.frame.size.width/2, 0);
            }else{
                //当前按钮后往右边可滚动的位置小于一半 显示的滚动内容
                
                // 如果剩下的内容可以整个显示出来就整个显示出来
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
        tmpFrame.size.height -= self.collectionView.frame.size.height;
        self.frame = tmpFrame;
        [self.moreContentView removeFromSuperview];
    }else {
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height += self.collectionView.frame.size.height;
        self.frame = tmpFrame;
        self.moreContentView.frame = self.bounds;
        [self insertSubview:self.moreContentView belowSubview:self.moreButton];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabMoreSelectedView:didSelectMoreButton:)]) {
        [self.delegate tabMoreSelectedView:self didSelectMoreButton:moreButton];
    }
}

@end
