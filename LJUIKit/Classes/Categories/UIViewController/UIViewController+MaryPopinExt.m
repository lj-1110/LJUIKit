//
//  UIViewController+MaryPopinExt.m
//  KaoLa
//
//  Created by 陈亮 on 2017/3/28.
//  Copyright © 2017年 陈亮. All rights reserved.
//

#import "UIViewController+MaryPopinExt.h"
#import <objc/runtime.h>

@implementation UIViewController (MaryPopinExt)

#pragma mark - property

- (NSMutableArray *)presentedControllers
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPresentedControllers:(NSMutableArray *)presentedControllers
{
    objc_setAssociatedObject(self, @selector(presentedControllers), presentedControllers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - private

- (void)ext_presentPopinController:(UIViewController *)popinController animated:(BOOL)animated
                       completion:(void(^)(void))completion
{
    UIViewController *cur = [self.presentedControllers lastObject];
    if (cur) {
        __weak typeof(self) wkself = self;
        [self dismissCurrentPopinControllerAnimated:NO completion:^{
            [wkself showController:popinController animated:animated completion:completion];
        }];
    }
    else {
        [self showController:popinController animated:animated completion:completion];
    }
}

- (void)ext_presentSubPopinController:(UIViewController *)popinController animated:(BOOL)animated
                           completion:(void(^)(void))completion
{
    CGPoint origin = self.view.frame.origin;
    CGSize size = [UIScreen mainScreen].bounds.size;
    [self presentPopinController:popinController fromRect:CGRectMake(-origin.x, -origin.y, size.width, size.height) animated:YES completion:nil];
}

- (void)ext_dismissCurrentPopinControllerAnimated:(BOOL)animated completion:(void(^)(void))completion
{
    __weak typeof(self) wkself = self;
    [self dismissCurrentPopinControllerAnimated:animated completion:^{
        [wkself.presentedControllers removeLastObject];
        
        UIViewController *pre = [wkself.presentedControllers lastObject];
        if (pre) {
            [wkself presentPopinController:pre animated:YES completion:completion];
        }
        else {
            if (completion) {
                completion();
            }
        }
    }];
}

- (void)ext_dismissAllControllerAnimated:(BOOL)animated completion:(void(^)(void))completion
{
    __weak typeof(self) wkself = self;
    [self dismissCurrentPopinControllerAnimated:animated completion:^{
        [wkself.presentedControllers removeAllObjects];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - private

- (void)showController:(UIViewController *)popinController animated:(BOOL)animated
                       completion:(void(^)(void))completion
{
    if (!self.presentedControllers) {
        self.presentedControllers = [NSMutableArray array];
    }
    [self.presentedControllers addObject:popinController];
    [self presentPopinController:popinController animated:animated completion:completion];
}


@end
