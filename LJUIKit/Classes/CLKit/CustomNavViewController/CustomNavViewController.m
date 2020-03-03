//
//  CustomNavViewController.m
//  BabyGod
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020年 mac. All rights reserved.
//

#import "CustomNavViewController.h"
#import "Masonry.h"

@interface CustomNavViewController ()


@end

@implementation CustomNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navBgView = [[UIView alloc] init];
    _navBgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_navBgView];
    
    _navContentView = [[UIView alloc] init];
    _navContentView.backgroundColor = [UIColor clearColor];
    [_navBgView addSubview:_navContentView];
    
    [self layoutWithTop:20];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.view bringSubviewToFront:self.navBgView];
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    
    CGFloat h = self.view.safeAreaInsets.top;;
    
    [self layoutWithTop:h];
}

- (void)layoutWithTop:(CGFloat)h
{
    [_navBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(h + 44);
    }];
    
    [_navContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.navBgView);
        make.height.mas_equalTo(44);
    }];
}

@end
