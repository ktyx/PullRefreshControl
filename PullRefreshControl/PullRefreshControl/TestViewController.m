//
//  TestViewController.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, strong)   UIImageView *logoView;
@property (nonatomic, strong)   UIImageView *circleView;
@property (nonatomic, weak)     IBOutlet UISlider    *circleSlider;
@property (nonatomic, weak)     IBOutlet UILabel     *textLabel;
@property (nonatomic, strong)   CAShapeLayer         *circleLayer;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
    
    [self.logoView addSubview:self.circleView];
    [self.view addSubview:self.logoView];
}

- (void)viewDidLayoutSubviews{
    self.logoView.center = self.view.center;
    self.logoView.bounds = CGRectMake(0, 0, 30, 30);
    self.circleView.frame = self.logoView.bounds;
}

- (void)viewDidAppear:(BOOL)animated{
    //[self.circleView.layer addAnimation:[self getTransformAnimation] forKey:nil];
    [self.logoView.layer addSublayer:self.circleLayer];
}

-(CABasicAnimation *)getTransformAnimation{
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"transform.rotation"]; //指定对transform.rotation属性做动画
    animation.duration            = 2.0f; //设定动画持续时间
    animation.byValue             = @(M_PI*2); //设定旋转角度，单位是弧度
    animation.fillMode            = kCAFillModeForwards;//设定动画结束后，不恢复初始状态之设置一
    animation.repeatCount         = 1000;//设定动画执行次数
    animation.removedOnCompletion = NO;//设定动画结束后，不恢复初始状态之设置二
    return animation;
}

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

- (IBAction)didSlide:(UISlider *)sender
{
    NSLog(@"slide value:%.2f",sender.value);
    self.circleLayer.strokeEnd = sender.value;
    //self.textLabel.layer
}

- (CALayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [self getShape];
    }
    return _circleLayer;
}

- (CAShapeLayer *)getShape{
    UIBezierPath *path       = [UIBezierPath bezierPathWithOvalInRect:self.logoView.bounds];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = [UIColor blueColor].CGColor;
    shapeLayer.lineWidth     = 1.32;
    shapeLayer.path          = path.CGPath;
    shapeLayer.frame         = self.logoView.bounds;
    shapeLayer.strokeEnd     = 0;
    return shapeLayer;
}

@end
