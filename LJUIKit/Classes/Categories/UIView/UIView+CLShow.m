//
//  UIView+CLShow.m
//  BabyGod
//
//  Created by KP_MAC_803 on 2020/2/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIView+CLShow.h"
#import <objc/runtime.h>
#import "Masonry.h"

@interface CustomBackgroundView : UIView

@end

@implementation CustomBackgroundView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end


@implementation UIView (CLShow)


- (CustomBackgroundView *)backgroundView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBackgroundView:(CustomBackgroundView *)backgroundView
{
    objc_setAssociatedObject(self, @selector(backgroundView), backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)showInView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShowInView:(UIView *)showInView
{
    objc_setAssociatedObject(self, @selector(showInView), showInView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public

- (void)showInView:(UIView *)view
{
    if (!view) {
        return;
    }
    self.showInView = view;
    
    CGSize s = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, s.width, s.height);
    
    //bg
    if (!self.backgroundView) {
        self.backgroundView = [[CustomBackgroundView alloc] init];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.backgroundView.alpha = 0;
        [view addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
    }
    
    //self
    if (!self.superview) {
        [self.backgroundView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
    }
    
    //等布局结束再执行动画
    [self animate:YES completion:nil];
}

- (void)hidden
{
    [self animate:NO completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
    }];
}

- (void)animate:(BOOL)animateIn completion:(void (^ __nullable)(BOOL finished))completion
{
    [self.layer removeAllAnimations];
    [self.backgroundView.layer removeAllAnimations];
    
    dispatch_block_t animations = ^{
        CGFloat alpha = animateIn ? 1.f : 0.f;
        self.alpha = alpha;
        self.backgroundView.alpha = alpha;
    };
    
    [UIView animateWithDuration:0.3 delay:0. usingSpringWithDamping:1.f initialSpringVelocity:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:completion];
}

@end
