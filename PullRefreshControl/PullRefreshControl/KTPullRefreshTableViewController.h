//
//  KTPullRefreshTableViewController.h
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KTPullRefreshText   =   0,
    KTPullRefreshGIF,
    KTPullRefreshLogo,
    KTPullRefreshFlashingText
}KTPullRefreshType;

@interface KTPullRefreshTableViewController : UITableViewController

- (id) initWithPullRefreshType:(KTPullRefreshType)type;

@end
