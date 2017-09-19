//
//  KTTextAppearAnimation
//  PullRefreshControl
//
//  Created by hdx on 2017/9/19.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTTextAppearAnimation : NSObject
- (CALayer *)appearAnimationLayerWithTitle:(NSString *)title;
- (void)addRefreshingAnimation;
- (void)animationTimeOffset:(CGFloat)offset;
@end
