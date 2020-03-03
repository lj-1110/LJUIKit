//
//  MBProgressHUD+gjMB.m
//  GJChargeSystem
//
//  Created by 廖维海 on 15/4/29.
//  Copyright (c) 2015年 www.cheweiguanjia.com. All rights reserved.
//

#import "MBProgressHUD+gjMB.h"

@implementation MBProgressHUD (gjMB)

+ (void)showHUDAutoHideWithText:(NSString *)text view:(UIView *)view
{
    if (view == nil) {
        return;
    }
    
    //隐藏旧的
    [MBProgressHUD hideHUDForView:view animated:NO];
    
    //新的
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:13];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:NO afterDelay:2];
}

+ (void)showHUDAutoHideWithText:(NSString *)text
{
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    [self showHUDAutoHideWithText:text view:view];
}

+ (void)showProgressHUDWithText:(NSString *)text view:(UIView *)view
{
    if (!view) {
        return;
    }
    
    //隐藏旧的
    [MBProgressHUD hideHUDForView:view animated:NO];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)showProgressHUDWithText:(NSString *)text
{
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    [self showProgressHUDWithText:text view:view];
}

+ (void)hideProgressHud
{
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    [self hideHUDForView:view animated:NO];
}

@end
