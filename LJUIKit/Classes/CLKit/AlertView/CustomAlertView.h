//
//  CustomAlertView.h
//  BabyGod
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;

typedef void(^click)(CustomAlertView *alert);

@interface CustomAlertView : UIView

/// 按钮点击时候禁止消失，default NO;
@property (nonatomic, assign) BOOL disableDismissWhenBtnClick;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

/// 内容
@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) NSAttributedString *contentAttributedText;

/// 如果只想显示一个按钮，则cancelTitle设置为空
@property (nonatomic, strong) NSString *cancelTitle;

/// 主题色
@property (nonatomic, strong) UIColor *tineColor;

/// 弹窗
/// @param img 图片
/// @param content 内容
/// @param sure 确定按钮标题 默认为“确定”
/// @param cancel 取消按钮标题 可以为空
/// @param sureAction 确定回调
/// @param cancelAction 取消回调
- (instancetype)initWithImage:(NSString *)img content:(NSString *)content sureTitle:(NSString *)sure cancelTitle:(NSString *)cancel sureAction:(click)sureAction cancelAction:(click)cancelAction;

@end

