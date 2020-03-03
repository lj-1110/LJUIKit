//
//  SBPageDataModel.h
//  chefu
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 shuangbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBPageModel.h"

@interface SBPageDataModel : NSObject

@property (nonatomic, strong) SBPageModel *pages;
@property (nonatomic, strong) NSArray *rdata;
@property (nonatomic, strong) NSDictionary *counts;

@end
