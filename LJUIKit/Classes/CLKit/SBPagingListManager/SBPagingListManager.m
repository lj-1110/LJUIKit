//
//  SBPagingListController.m
//  chefu
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 shuangbang. All rights reserved.
//

#import "SBPagingListManager.h"
#import "SBPageDataModel.h"
#import "MBProgressHUD+gjMB.h"
#import "NSObject+MJKeyValue.h"

#define kPageSize 20

@interface SBPagingListManager ()

@property (nonatomic, weak) UIScrollView *tableView;
@property (assign, nonatomic) NSInteger nextPage;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *footer;
@property (assign, nonatomic) BOOL isRequesting;

@end

@implementation SBPagingListManager

- (instancetype)initWithDataSource:(id<SBPagingListDataSource>)dataSource
{
    self = [super init];
    if (self) {
        
        self.dataSource = dataSource;
        
        self.tableView = [self.dataSource pageTableView];
        
        __weak typeof(self) wkself = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [wkself requestFirstPage];
        }];
        header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.tableView.mj_header = header;
    }
    return self;
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MJRefreshAutoNormalFooter *)footer
{
    if (!_footer) {
        __weak typeof(self) wkself = self;
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [wkself requestNextPage];
        }];
    }
    return _footer;
}

- (void)footerHandle:(SBPageModel *)data
{
    if (!data.IsLastPage) {
        self.tableView.mj_footer = self.footer;
    }
    else {
        self.tableView.mj_footer = nil;
    }
}

- (void)requestFirstPage
{
    _nextPage = 1;
    [self requestNextPage];
}

- (void)requestNextPage
{
    if (self.isRequesting) {
        return;
    }
    self.isRequesting = YES;
    __weak typeof(self) wkself = self;
    [self.dataSource requestListWithCurPage:_nextPage pageSize:kPageSize response:^(id dataObj, NSError *error) {
        [wkself requestHandle:dataObj error:error];
        wkself.isRequesting = NO;
    }];
}

- (void)requestHandle:(SBPageDataModel *)dataObj error:(NSError *)error
{
    if (self.nextPage == 1) {
        [self.tableView.mj_header endRefreshing];
    }
    else {
        [self.tableView.mj_footer endRefreshing];
    }
    
    if (error) {
        [MBProgressHUD showHUDAutoHideWithText:error.localizedDescription];
    }
    else {
        
        NSString *classname = [self.dataSource cellDataClassName];
        Class c = NSClassFromString(classname);
        NSArray *rdata = [c mj_objectArrayWithKeyValuesArray:dataObj.rdata];
        if (_nextPage == 1) {
            self.dataList = [NSMutableArray arrayWithArray:rdata];
        }
        else {
            [self.dataList addObjectsFromArray:rdata];
        }
        if ([self.tableView isKindOfClass:[UITableView class]]) {
            [(UITableView *)self.tableView reloadData];
        }
        if ([self.tableView isKindOfClass:[UICollectionView class]]) {
            [(UICollectionView *)self.tableView reloadData];
        }
        
        [self footerHandle:dataObj.pages];
        
        self.nextPage++;
    }
}

@end
