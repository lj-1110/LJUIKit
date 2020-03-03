//
//  COBaseWebController.m
//  CWGJCarOwner
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 mutouren. All rights reserved.
//

#import "COBaseWebController.h"
#import "Masonry.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface COBaseWebController () <WKNavigationDelegate>

@property (strong, nonatomic) UIProgressView *myProgressView;
@property (strong, nonatomic) UIView *bgView;

@end

@implementation COBaseWebController

// 记得取消监听
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressTintColor = [UIColor grayColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    UIImage* backImg = [UIImage imageNamed:@"nav_back.png"];
//    UIButton* backBtn = [[UIButton alloc] init];
//    [backBtn setImage:backImg forState:UIControlStateNormal];
//    [backBtn setFrame:CGRectMake(0, 0, 26, 44)];
//    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    [backBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//
//    UIImage* closeImg = [UIImage imageNamed:@"close_icon.png"];
//    UIButton* closeBtn = [[UIButton alloc] init];
//    [closeBtn setImage:closeImg forState:UIControlStateNormal];
//    [closeBtn setFrame:CGRectMake(0, 0, 26, 44)];
//    UIBarButtonItem* closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
//    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.navigationItem setLeftBarButtonItems:@[backItem,closeItem]];
    
    [self.view addSubview:self.myProgressView];
    [self.myProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }
        else {
            make.top.equalTo(self.view.mas_top).offset(0);
        }
    }];
    
    [self creatWebView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)creatWebView {
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectZero];
    bg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgView = bg;
    
    //webview
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSString *u = [self readyUrl];
    if ([u length]) {
        self.url = u;
    }

    [self requestUrl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - observe

/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
 */



- (void)requestUrl
{
    NSURL *url = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [self.webView loadRequest:request];
}


#pragma mark - public

- (NSString *)readyUrl
{
    return nil;
}


#pragma mark - nav

- (void)leftBtnClick
{
    if (self.isBackToClose) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)closeBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 0)];
        _myProgressView.tintColor = self.progressTintColor;
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}

- (WKWebView *)webView
{
    if(_webView == nil)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
        _webView.opaque = NO;
        _webView.multipleTouchEnabled = YES;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _webView;
}

@end
