//
//  KTFlashingTextRefreshHeader.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/19.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTFlashingTextRefreshHeader.h"
#import "KTFlashingTextAnimation.h"
#import "KTTextAppearAnimation.h"
#import <CoreText/CoreText.h>
#define FlashingTextFontSize        17.0

@interface KTFlashingTextRefreshHeader ()
@property (nonatomic, strong)   UILabel     *refreshingLabel;
@property (nonatomic, strong)   NSString    *pullingTitle;
@property (nonatomic, strong)   NSString    *refreshingTitle;
@property (nonatomic, strong)   CALayer     *pathLayer;
@property (nonatomic, strong)   KTFlashingTextAnimation     *flashingAnimation;
@property (nonatomic, strong)   KTTextAppearAnimation       *appearAnimation;
@property (nonatomic, assign)   CGFloat headerAnimationHeight;
@end


@implementation KTFlashingTextRefreshHeader

- (void)prepare {
    [super prepare];
    self.flashingAnimation = [KTFlashingTextAnimation new];
    self.flashingAnimation.animatedView = self.refreshingLabel;
    self.flashingAnimation.shadowWidth = 30.;
    self.flashingAnimation.duration = 1.2f;
    
    _pullingTitle = @"下拉刷新数据";
    _refreshingTitle = @"刷新数据中";
    
    _appearAnimation = [KTTextAppearAnimation new];
    self.pathLayer = [_appearAnimation appearAnimationLayerWithTitle:_pullingTitle];
    [self.refreshingLabel.layer addSublayer:_pathLayer];
    [_appearAnimation addRefreshingAnimation];
}

- (UILabel *)refreshingLabel {
    if (!_refreshingLabel) {
        _refreshingLabel = [UILabel new];
        _refreshingLabel.font = (__bridge id)CTFontCreateWithName(CFSTR("HelveticaNeue-Thin"), FlashingTextFontSize, NULL);
        _refreshingLabel.textAlignment = NSTextAlignmentCenter;
        _refreshingLabel.textColor = [UIColor redColor];
        [self addSubview:_refreshingLabel];
    }
    return _refreshingLabel;
}


- (void)placeSubviews {
    [super placeSubviews];
    if (self.refreshingLabel.hidden) {
        return;
    }
    BOOL noConstrainsOnRefreshingLabel = self.refreshingLabel.constraints.count == 0;
    if (noConstrainsOnRefreshingLabel) {
        self.refreshingLabel.mj_x = 0;
        self.refreshingLabel.mj_y = 5;
        self.refreshingLabel.mj_size = self.mj_size;
        _pathLayer.position = self.refreshingLabel.center;
        CGPoint point = _pathLayer.position;
        point.y = self.refreshingLabel.mj_size.height/2.0;
        _pathLayer.position = point;
    }
    NSInteger headerHeight = self.scrollView.mj_offsetY;
    if (headerHeight == -64) {
        self.headerAnimationHeight = 64;
    } else {
        self.headerAnimationHeight = 20;
    }
    
}


- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    switch (state)
    {
        case MJRefreshStateIdle:
            self.refreshingLabel.text = @"";//_pullingTitle;
            [self.refreshingLabel.layer addSublayer:_pathLayer];
            [self.flashingAnimation stop];
            break;
        
        case MJRefreshStatePulling:
            self.refreshingLabel.text = _pullingTitle;
            [self.refreshingLabel.layer addSublayer:_pathLayer];
            [self.flashingAnimation stop];
            break;
            
        case MJRefreshStateRefreshing:
            self.refreshingLabel.text = _refreshingTitle;
            self.pathLayer.beginTime = 0.0f;
            self.pathLayer.timeOffset = 0.0f;
            [self.pathLayer removeFromSuperlayer];
            [self.flashingAnimation start];
            break;
        default:
            break;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    NSValue *value = change[@"new"];
    CGPoint point = [value CGPointValue];
    if (-point.y < MJRefreshHeaderHeight && self.scrollView.isDragging) {
        [self.refreshingLabel.layer addSublayer:_pathLayer];
    }
    if (-point.y - _headerAnimationHeight > 0 && self.scrollView.isDragging) {
        [_appearAnimation animationTimeOffset:(-point.y - _headerAnimationHeight) / MJRefreshHeaderHeight * 10];
    }
    
}
@end
