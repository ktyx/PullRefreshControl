//
//  FOTextRefreshAutoFooter.m
//  forum
//
//  Created by hdx on 2017/9/17.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTTextRefreshAutoFooter.h"

@interface KTTextRefreshAutoFooter ()
@property (weak, nonatomic) UILabel *label;
@end

@implementation KTTextRefreshAutoFooter

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.label.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉刷新";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载数据中";
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"木有数据了";
            break;
        default:
            break;
    }
}

@end
