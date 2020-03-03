//
//  CustomAlertController.m
//  BabyGod
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020年 mac. All rights reserved.
//

#import "CustomAlertController.h"

@interface CustomAlertController ()

@property (nonatomic, copy) void(^sureAction)(void);
@property (nonatomic, copy) void(^cancelAction)(CustomAlertController *vc);

@end

@implementation CustomAlertController

- (instancetype)initWithImage:(NSString *)img content:(NSString *)content sureTitle:(NSString *)sure cancelTitle:(NSString *)cancel sureAction:(void (^)(void))sureAction cancelAction:(void (^)(CustomAlertController *vc))cancelAction
{
    self = [super init];
    if (self) {
        self.showVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([self.showVc isKindOfClass:[UINavigationController class]]) {
            self.showVc = ((UINavigationController *)self.showVc).visibleViewController;
        }

        self.sureAction = sureAction;
        self.cancelAction = cancelAction;
        
        _alertView = [[CustomAlertView alloc] initWithImage:img content:content sureTitle:sure cancelTitle:cancel sureAction:^(CustomAlertView *alert){
            [self.showVc ext_dismissCurrentPopinControllerAnimated:YES completion:^{
                if (self.sureAction) {
                    self.sureAction();
                }
            }];
        } cancelAction:^(CustomAlertView *alert){
            if (self.cancelAction) {
                self.cancelAction(self);
            }
            else {
                [self.showVc ext_dismissCurrentPopinControllerAnimated:YES completion:nil];
            }
        }];
    }
    return self;
}

- (void)loadView
{
    self.view = self.alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)show
{
    [self showWithOption:BKTPopinDefault transitionStyle:BKTPopinTransitionStyleCrossDissolve];
}

- (void)showDisableAutoDismiss
{
    [self showWithOption:BKTPopinDisableAutoDismiss transitionStyle:BKTPopinTransitionStyleCrossDissolve];
}

- (void)showWithOption:(BKTPopinOption)option transitionStyle:(BKTPopinTransitionStyle)transitionStyle
{
    [self update];
    self.popinOptions = option;
    self.popinTransitionStyle = transitionStyle;

    [self.showVc ext_presentPopinController:self animated:YES completion:nil];
}

- (void)dismiss
{
    [_showVc ext_dismissCurrentPopinControllerAnimated:YES completion:nil];
}

- (void)dismissCompletion:(void(^)(void))completion;
{
    [_showVc ext_dismissCurrentPopinControllerAnimated:YES completion:completion];
}

+ (void)dismissAll
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc ext_dismissAllControllerAnimated:YES completion:nil];
}

- (void)update
{
    CGSize s = [_alertView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGPoint c = _alertView.center;
    _alertView.frame = CGRectMake(0, 0, s.width, s.height);
    _alertView.center = c;
}

@end
