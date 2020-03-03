//
//  CustomAlertView.m
//  BabyGod
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020年 mac. All rights reserved.
//

#import "CustomAlertView.h"
#import "UIView+CLShow.h"
#import "Masonry.h"

@interface CustomAlertView ()

@property (nonatomic, copy) click sureAction;
@property (nonatomic, copy) click cancelAction;

@property (nonatomic, assign) CGFloat h;

@end

@implementation CustomAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithImage:(NSString *)img content:(NSString *)content sureTitle:(NSString *)sure cancelTitle:(NSString *)cancel sureAction:(void(^)(CustomAlertView *alert))sureAction cancelAction:(void(^)(CustomAlertView *alert))cancelAction;
{
    self = [super init];
    if (self) {
        self.alpha = 0;
        
        self.tintColor = [UIColor colorWithRed:37/255.f green:206/255.f blue:209/255.f alpha:1];
        
        self.sureAction = sureAction;
        self.cancelAction = cancelAction;
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:img];
        UIImageView *imgView = [[UIImageView alloc] init];
        self.imageView = imgView;
        imgView.image = image;
        [self addSubview:imgView];

        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.text = content;
        self.contentLabel = contentLabel;
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn = sureBtn;
        [sureBtn setTitle:sure forState:UIControlStateNormal];
        sureBtn.backgroundColor = self.tintColor;
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        sureBtn.layer.cornerRadius = 5;
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelTitle = cancel;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn = cancelBtn;
        [cancelBtn setTitle:cancel forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.layer.borderColor = self.tintColor.CGColor;
        cancelBtn.layer.borderWidth = 0.5;
        [self addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self updateLayoutAndFrame];
    }
    
    return self;
}

//- (void)updateLayoutAndFrame
//{
//    CGFloat w = 270;
//
//    self.h = 0;
//    CGFloat topSpace = 32;
//    self.h += topSpace;
//
//    [self.imageView sd_resetLayout];
//    self.imageView.sd_layout
//    .centerXEqualToView(self)
//    .widthIs(self.imageView.image.size.width)
//    .heightIs(self.imageView.image.size.height)
//    .topSpaceToView(self, topSpace);
//
//    self.h += self.imageView.image.size.height;
//
//    topSpace = 24;
//    self.h += topSpace;
//
//    CGFloat margin = 12;
//    [self.contentLabel sd_resetLayout];
//    self.contentLabel.sd_layout
//    .leftSpaceToView(self, margin)
//    .rightSpaceToView(self, margin)
//    .topSpaceToView(self.imageView, topSpace)
//    .autoHeightRatio(0);
//
//    self.contentLabel.width = w-2*margin;
//    [self.contentLabel sizeToFit];
//    CGSize s = self.contentLabel.frame.size;
//    self.h += s.height;
//
//    topSpace = 24;
//    self.h += topSpace;
//
//    CGFloat btnH = 48;
//    self.h += btnH;
//
//    [self.cancelBtn sd_resetLayout];
//    [self.sureBtn sd_resetLayout];
//    if (![self.cancelTitle length]) {
//        self.sureBtn.sd_layout
//        .leftSpaceToView(self, 22)
//        .rightSpaceToView(self, 22)
//        .heightIs(btnH)
//        .topSpaceToView(self.contentLabel, topSpace);
//    }
//    else {
//        self.sureBtn.sd_layout
//        .rightSpaceToView(self, 15)
//        .heightIs(btnH)
//        .widthIs(105)
//        .topSpaceToView(self.contentLabel, topSpace);
//
//        self.cancelBtn.sd_layout
//        .leftSpaceToView(self, 15)
//        .widthRatioToView(self.sureBtn, 1)
//        .heightRatioToView(self.sureBtn, 1)
//        .topSpaceToView(self.contentLabel, topSpace);
//    }
//
//    CGFloat bottomMargin = 20;
//    self.h += bottomMargin;
//
//    [self setupAutoHeightWithBottomView:self.sureBtn bottomMargin:bottomMargin];
//
//}

- (void)updateLayoutAndFrame
{
    CGFloat w = 270;
    CGFloat topSpace = 32;

    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(topSpace);
    }];

    topSpace = 24;

    CGFloat margin = 12;
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w-2*margin);
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.top.equalTo(self.imageView.mas_bottom).offset(topSpace);
    }];


    topSpace = 24;
    CGFloat btnH = 48;

    CGFloat bottomMargin = 20;
    if (![self.cancelTitle length]) {
        [self.sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(22);
            make.right.equalTo(self).offset(-22);
            make.height.mas_equalTo(btnH);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(topSpace);
            make.bottom.equalTo(self).offset(-bottomMargin);
        }];
    }
    else {
        [self.sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(btnH);
            make.width.mas_equalTo(105);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(topSpace);
            make.bottom.equalTo(self).offset(-bottomMargin);
        }];

        [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.width.height.centerY.equalTo(self.sureBtn);
        }];
    }

}

- (void)sureBtnClick
{
    [self tryHidden];

    if (self.sureAction) {
        self.sureAction(self);
    }
}

- (void)cancelBtnClick
{
    [self tryHidden];
    
    if (self.cancelAction) {
        self.cancelAction(self);
    }
}

- (void)tryHidden
{
    BOOL isHiden = YES;
    if (self.disableDismissWhenBtnClick) {
        isHiden = NO;
    }

    if (isHiden) {
        [self hidden];
    }
}


//MBProgressHUD自定义视图，必须实现该方法
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(270, 0);
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    _cancelTitle = cancelTitle;
    [self.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    self.cancelBtn.hidden = [cancelTitle length] ? NO : YES;
    [self updateLayoutAndFrame];
}

- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    self.contentLabel.text = contentText;
    [self updateLayoutAndFrame];
}

- (void)setContentAttributedText:(NSAttributedString *)contentAttributedText
{
    _contentAttributedText = contentAttributedText;
    self.contentLabel.attributedText = contentAttributedText;
    [self updateLayoutAndFrame];
}



@end
