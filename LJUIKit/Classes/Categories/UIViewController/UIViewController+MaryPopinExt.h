//
//  UIViewController+MaryPopinExt.h
//  KaoLa
//
//  Created by 陈亮 on 2017/3/28.
//  Copyright © 2017年 陈亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MaryPopin.h"

@interface UIViewController (MaryPopinExt)


/// 支持弹出多个对话框
/// @param popinController 要弹出的controller
/// @param animated 动画
/// @param completion 完成回调
- (void)ext_presentPopinController:(UIViewController *)popinController animated:(BOOL)animated
                        completion:(void(^)(void))completion;


/// 与ext_presentPopinController配套使用
/// @param animated 动画
/// @param completion 完成回调
- (void)ext_dismissCurrentPopinControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;


/// 关闭所有弹窗
/// @param animated 动画
/// @param completion 完成回调
- (void)ext_dismissAllControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;


/// 支持对话框中弹出对话框，并且按屏幕坐标居中显示
/// @param popinController 要弹出的controller
/// @param animated 动画
/// @param completion 完成回调
- (void)ext_presentSubPopinController:(UIViewController *)popinController animated:(BOOL)animated
                        completion:(void(^)(void))completion;

@end
