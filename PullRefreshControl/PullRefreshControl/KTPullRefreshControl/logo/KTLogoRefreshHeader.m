//
//  KTLogoRefreshHeader.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTLogoRefreshHeader.h"

@interface KTLogoRefreshHeader ()
@property (nonatomic, assign)   BOOL            hasRefreshed;
@property (nonatomic, strong)   UIImageView     *logoView;
@property (nonatomic, strong)   UIImageView     *circleView;
@property (nonatomic, strong)   CAShapeLayer    *circleLayer;
@property (nonatomic, strong)   UIColor         *circleColor;
@end

@implementation KTLogoRefreshHeader
CGRect kZZZLogoViewBounds = {0,0,30,30};

- (void)prepare
{
    [super prepare];
    _circleColor = [UIColor colorWithRed:255/255.0 green:24/255.0 blue:152/255.0 alpha:1.0];
    [self.logoView addSubview:self.circleView];
    [self.logoView.layer addSublayer:self.circleLayer];
    
    [self addSubview:self.logoView];
    self.hasRefreshed = NO;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.logoView.center = CGPointMake(self.mj_w/2.0, self.mj_h/2.0 + 5.0);
    self.logoView.bounds = kZZZLogoViewBounds;
    self.circleView.frame = self.logoView.bounds;
}

#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.circleView.hidden = YES;
            self.circleLayer.hidden = NO;
            break;
        case MJRefreshStatePulling:
            break;
        case MJRefreshStateRefreshing:
            
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            self.circleLayer.hidden = YES;
            [CATransaction commit];
            
            self.circleView.hidden = NO;
            [self.circleView.layer addAnimation:[self createTransformAnimation] forKey:nil];
            
            self.hasRefreshed = YES;
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if (self.hasRefreshed) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeEnd = 1.0;
        [CATransaction commit];
        self.hasRefreshed = NO;
    }else{
        NSLog(@"stroke pulll %.2f",pullingPercent);
        self.circleLayer.strokeEnd = pullingPercent * 0.85;
    }
}



#pragma mark - setter & getter

- (UIImageView *)logoView{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        _logoView.image = [UIImage imageNamed:@"pull_refresh_logo"];
    }
    return _logoView;
}

- (UIImageView *)circleView{
    if (!_circleView) {
        _circleView = [[UIImageView alloc] init];
        _circleView.image = [UIImage imageNamed:@"pull_refresh_circle"];
    }
    return _circleView;
}

- (CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [self creatCircleShapeLayerWithBounds:kZZZLogoViewBounds];
        
        [_circleLayer setBackgroundColor:[UIColor purpleColor].CGColor];
    }
    return _circleLayer;
}

-(CABasicAnimation *)createTransformAnimation{
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration            = 1.2f;
    animation.byValue             = @(M_PI*2);
    animation.fillMode            = kCAFillModeForwards;
    animation.repeatCount         = 999999;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAShapeLayer *)creatCircleShapeLayerWithBounds:(CGRect)circleRect{
    UIBezierPath *path       = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = _circleColor.CGColor;
    shapeLayer.lineWidth     = 1.24;
    shapeLayer.path          = path.CGPath;
    shapeLayer.frame         = self.logoView.bounds;
    shapeLayer.strokeEnd     = 0;
    return shapeLayer;
}

- (void)endRefreshing{
    [self.circleView.layer removeAllAnimations];
    [super endRefreshing];
}
@end
