//
//  KTPullRefreshTableViewController.m
//  PullRefreshControl
//
//  Created by hdx on 2017/9/18.
//  Copyright © 2017年 ksrsj.com. All rights reserved.
//

#import "KTPullRefreshTableViewController.h"
#import "KTTextRefreshHeader.h"
#import "KTTextRefreshAutoFooter.h"
#import "KTLogoRefreshHeader.h"
#import "KTGIFRefreshHeader.h"
#import "KTFlashingTextRefreshHeader.h"
#define KTPullRefreshTableViewCellReuseID   @"KTPullRefreshTableViewCellReuseID"

@interface KTPullRefreshTableViewController ()
@property (nonatomic, assign)   NSInteger       mPullRefreshType;
@property (nonatomic, strong)   NSMutableArray  *mCellTextArray;
- (void) reloadTableData;
- (void) loadMoreTableData;
@end

@implementation KTPullRefreshTableViewController

- (id) initWithPullRefreshType:(KTPullRefreshType)type
{
    self = [super init];
    if (self)
    {
        _mPullRefreshType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _mCellTextArray = [NSMutableArray new];
    for (int i = 0; i < 40; i++)
    {
        [_mCellTextArray addObject:[NSString stringWithFormat:@"可爱的第%d行飘过~",i]];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KTPullRefreshTableViewCellReuseID];
    
    if (_mPullRefreshType == KTPullRefreshText)
    {
        KTTextRefreshHeader *header = [KTTextRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableData)];
        header.automaticallyChangeAlpha = YES;
        self.tableView.mj_header = header;
        
        KTTextRefreshAutoFooter *footer = [KTTextRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableData)];
        footer.automaticallyRefresh = YES;
        footer.automaticallyHidden = YES;
        self.tableView.mj_footer = footer;
    }else if(_mPullRefreshType == KTPullRefreshLogo)
    {
        KTLogoRefreshHeader *header = [KTLogoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableData)];
        self.tableView.mj_header = header;
    }else if(_mPullRefreshType == KTPullRefreshGIF)
    {
        KTGIFRefreshHeader *header = [KTGIFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableData)];
        header.automaticallyChangeAlpha = YES;
        self.tableView.mj_header = header;
    }else if(_mPullRefreshType == KTPullRefreshFlashingText)
    {
        KTFlashingTextRefreshHeader *header = [KTFlashingTextRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableData)];
        self.tableView.mj_header = header;
    }
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
    return _mCellTextArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTPullRefreshTableViewCellReuseID forIndexPath:indexPath];
    NSString *cellName = [_mCellTextArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellName;
    return cell;
}

- (void) reloadTableData
{
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1.32*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

- (void) loadMoreTableData
{
    if (_mCellTextArray.count > 60)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
        return;
    }
    NSInteger startIndex = _mCellTextArray.count + 1;
    NSInteger endIndex = startIndex + 5;
    for (NSInteger i = startIndex; i <= endIndex; i++)
    {
        [_mCellTextArray addObject:[NSString stringWithFormat:@"可爱的第%ld行飘过~",i]];
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
