//
//  SBPagingListController.h
//  chefu
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 shuangbang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "SBPageDataModel.h"

typedef void (^ResponseHandler)(SBPageDataModel *dataObj,NSError *error);

@protocol SBPagingListDataSource <NSObject>
@required

/// tableview or  collectionview
- (id)pageTableView;

//cell数据对应类名
- (NSString *)cellDataClassName;

///  再这里添加请求，请求结束调用handler
/// @param curPage 当前页
/// @param pageSize 大小
/// @param handler 请求结束调用
- (void)requestListWithCurPage:(NSInteger)curPage pageSize:(NSInteger)pageSize response:(ResponseHandler)handler;

@end

@interface SBPagingListManager : NSObject


- (instancetype)initWithDataSource:(id<SBPagingListDataSource>)dataSource;


/// 列表数据
@property (strong, nonatomic) NSMutableArray *dataList;

@property (nonatomic, weak) id <SBPagingListDataSource> dataSource;

/// 请求首页
- (void)requestFirstPage;

/// 请求下一页
- (void)requestNextPage;

@end
