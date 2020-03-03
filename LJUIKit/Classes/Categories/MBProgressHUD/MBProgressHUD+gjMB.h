//
//  MBProgressHUD+gjMB.h
//  GJChargeSystem
//
//  Created by 廖维海 on 15/4/29.
//  Copyright (c) 2015年 www.cheweiguanjia.com. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (gjMB)

//自动消失 提示框
+ (void)showHUDAutoHideWithText:(NSString *)text;
+ (void)showHUDAutoHideWithText:(NSString *)text view:(UIView *)view;

//进度条
+ (void)showProgressHUDWithText:(NSString *)text;
+ (void)showProgressHUDWithText:(NSString *)text view:(UIView *)view;

//隐藏
+ (void)hideProgressHud;

@end
