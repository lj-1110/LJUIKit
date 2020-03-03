//
//  UINavigationController+CLReplace.h
//  CLUIKit
//
//  Created by KP_MAC_803 on 2020/2/26.
//  Copyright © 2020 KP_MAC_803. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (CLReplace)


///  替换当前controller
/// @param vc 要替换的controller, 有动画
- (void)replaceViewController:(UIViewController *)vc;


/// 替换当前controller
/// @param vc 要替换的controller
/// @param animated 动画
- (void)replaceViewController:(UIViewController *)vc animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
