//
//  KTGIFRefreshHeader.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTGIFRefreshHeader.h"

@implementation KTGIFRefreshHeader

- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    
    /*
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_loop_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=19; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_pull_%zd", i]];
        [pullingImages addObject:image];
    }
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_release_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"放开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
     */
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_loop_%zd", i]];
        [idleImages addObject:image];
    }
    
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=19; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_pull_%zd", i]];
        [pullingImages addObject:image];
    }
    
    
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_release_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"放开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
}

@end
