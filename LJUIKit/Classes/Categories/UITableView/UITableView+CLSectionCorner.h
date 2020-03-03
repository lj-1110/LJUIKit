//
//  UITableView+CLSectionCorner.h
//  BabyGod
//
//  Created by mac on 2020/1/22.
//  Copyright © 2020年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CLSectionCorner)


/// 在tableview delegate willDisplayCell 中调用此方法， 设置整个sectiony圆角
/// @param cell cell
/// @param indexPath indexPath
- (void)corner_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/// 在tableview delegate willDisplayCell 中调用此方法， 设置整个sectiony圆角
/// @param cell cell
/// @param indexPath indexPath
/// @param radius 半径
- (void)corner_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath radius:(float)radius;

@end

NS_ASSUME_NONNULL_END
