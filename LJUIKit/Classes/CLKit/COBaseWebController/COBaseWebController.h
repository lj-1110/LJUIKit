//
//  COBaseWebController.h
//  CWGJCarOwner
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 mutouren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface COBaseWebController : UIViewController

- (id)initWithUrl:(NSString *)url;

@property (nonatomic, copy) NSString *url;

@property (strong, nonatomic) WKWebView *webView;

@property (nonatomic, strong) UIColor *progressTintColor;

//返回时是否关闭网页
@property (nonatomic, assign) BOOL isBackToClose;

//overide , 注册服务端要调用的方法

- (NSString *)readyUrl;

- (void)leftBtnClick;

@end
