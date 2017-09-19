//
//  KTPullRefreshTableViewController.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTPullRefreshControlListController.h"
#import "KTPullRefreshTableViewController.h"
#import "TestViewController.h"
#define KTPullRefreshControlListCellReuseID   @"KTPullRefreshControlListCellReuseID"

@interface KTPullRefreshControlListController ()
@property (nonatomic, strong)   NSMutableArray  *mControlArray;
@end

@implementation KTPullRefreshControlListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上拉下拉刷新控件";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _mControlArray = [NSMutableArray new];
    [_mControlArray addObject:@"纯文本"];
    [_mControlArray addObject:@"网易刷新控件"];
    [_mControlArray addObject:@"什么值得买刷新控件"];
    [_mControlArray addObject:@"仿半糖刷新控件"];
    [_mControlArray addObject:@"测试页面"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KTPullRefreshControlListCellReuseID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mControlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTPullRefreshControlListCellReuseID forIndexPath:indexPath];
    NSString *cellName = [_mControlArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4)
    {
        TestViewController *testVC = [[TestViewController alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
        return;
    }
    
    KTPullRefreshType refreshType = KTPullRefreshText;
    if(indexPath.row == 1)
    {
        refreshType = KTPullRefreshGIF;
    }else if (indexPath.row == 2)
    {
        refreshType = KTPullRefreshLogo;
    }else if(indexPath.row == 3)
    {
        refreshType = KTPullRefreshFlashingText;
    }
    KTPullRefreshTableViewController *tableVC = [[KTPullRefreshTableViewController alloc] initWithPullRefreshType:refreshType];
    [self.navigationController pushViewController:tableVC animated:YES];
}


@end
