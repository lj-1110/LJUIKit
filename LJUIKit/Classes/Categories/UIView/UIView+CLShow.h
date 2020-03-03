//
//  UIView+CLShow.h
//  BabyGod
//
//  Created by KP_MAC_803 on 2020/2/28.
//  Copyright © 2020 mac. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CLShow)


/// fade show
/// @param view 父视图
- (void)showInView:(UIView *)view;


/// fade hidden
- (void)hidden;

@end

NS_ASSUME_NONNULL_END
