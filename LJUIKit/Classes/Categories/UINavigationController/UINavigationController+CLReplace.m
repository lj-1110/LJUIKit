//
//  UINavigationController+CLReplace.m
//  CLUIKit
//
//  Created by KP_MAC_803 on 2020/2/26.
//  Copyright © 2020 KP_MAC_803. All rights reserved.
//

#import "UINavigationController+CLReplace.h"


@implementation UINavigationController (CLReplace)


- (void)replaceViewController:(UIViewController *)vc
{
    [self replaceViewController:vc animated:YES];
}


- (void)replaceViewController:(UIViewController *)vc animated:(BOOL)animated
{
    if (!vc) {
        return;
    }
    
    NSMutableArray *marr = [NSMutableArray arrayWithArray:self.viewControllers];
    if ([marr count]) {
        [marr removeLastObject];
    }
    [marr addObject:vc];
    
    [self setViewControllers:marr animated:animated];
}

@end
