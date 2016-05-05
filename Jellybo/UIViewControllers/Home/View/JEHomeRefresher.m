//
//  JEHomeRefresher.m
//  Jellybo
//
//  Created by POON on 16/5/5.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHomeRefresher.h"

@interface JEHomeRefresher()
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation JEHomeRefresher

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kThemeColor;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
//    // logo
//    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//    logo.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:logo];
//    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(0, 0, 200, 20);
    self.label.centerX = self.width/2;
    self.label.centerY = self.height/2;
//
//    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
    self.loading.centerY = self.label.centerY;
    self.loading.right = self.label.left - 10;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.label.text = @"Pull to refresh";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.label.text = @"Release to refresh";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"Refreshing..";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //CGFloat red = 1.0 - pullingPercent * 0.5;
    //CGFloat green = 0.5 - 0.5 * pullingPercent;
    //CGFloat blue = 0.5 * pullingPercent;
    //self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
