//
//  SBPageModel.h
//  chefu
//
//  Created by mac on 2018/8/25.
//  Copyright © 2018年 shuangbang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBPageModel : NSObject

@property (nonatomic, assign) NSInteger PageCount;
@property (nonatomic, assign) NSInteger CurrentPage;
@property (nonatomic, assign) NSInteger PageSize;
@property (nonatomic, assign) NSInteger DataCount;
@property (nonatomic, assign) NSInteger IsLastPage;

@end
