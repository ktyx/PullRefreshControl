//
//  KTFlashingTextAnimation
//  PullRefreshControl
//
//  Created by hdx on 2017/9/19.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTFlashingTextAnimation : NSObject
// 需要展示动画的View
@property (weak, nonatomic) UIView *animatedView;
// 动画时长
@property (assign, nonatomic) NSTimeInterval duration;
// 阴影宽度
@property (assign, nonatomic) CGFloat shadowWidth;
// 重复次数
@property (assign, nonatomic) CGFloat repeatCount;
// 阴影背景
@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
- (void)start;
- (void)stop;
@end
