//
//  CustomAlertController.h
//  BabyGod
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
#import <UIViewController+MaryPopinExt.h>


@interface CustomAlertController : UIViewController

@property (nonatomic, strong, readonly) CustomAlertView *alertView;

- (instancetype)initWithImage:(NSString *)img content:(NSString *)content sureTitle:(NSString *)sure cancelTitle:(NSString *)cancel sureAction:(void(^)(void))sureAction cancelAction:(void(^)(CustomAlertController *vc))cancelAction;


/// 父controller ,default 当前显示的controller
@property (nonatomic, weak) UIViewController *showVc;

- (void)show;
- (void)showDisableAutoDismiss;
- (void)showWithOption:(BKTPopinOption)option transitionStyle:(BKTPopinTransitionStyle)transitionStyle;
- (void)dismiss;
- (void)dismissCompletion:(void(^)(void))completion;
+ (void)dismissAll;

/// 刷新frame
- (void)update;

@end

