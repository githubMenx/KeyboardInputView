//
//  CoverView.m
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "CoverView.h"
#import <objc/runtime.h>

static const char coverViewKey = '\0';
static const double coverViewDuration = 0.25;

@implementation CoverView

+ (void)showInViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    // 利用runtime从控制器中取出coverViewKey
    CoverView *coverViewValue = objc_getAssociatedObject(viewController, &coverViewKey);
    // 如果没有就创建并利用runtime给该控制器添加属性coverViewKey
    if (!coverViewValue) {
        CoverView *coverView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CoverView class]) owner:nil options:nil] firstObject];
        coverView.frame = viewController.view.bounds;
        coverView.alpha = 0.0;
        [viewController.navigationController.view addSubview:coverView];
        objc_setAssociatedObject(viewController, &coverViewKey, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        coverViewValue = coverView;
    }
    // 执行动画
    coverViewValue.hidden = NO;
    [UIView animateWithDuration:coverViewDuration animations:^{
        coverViewValue.alpha = 1.0;
    }];
}

+ (void)hideInViewController:(UIViewController *)viewController {
    CoverView *coverViewValue = objc_getAssociatedObject(viewController, &coverViewKey);
    // 执行动画
    [UIView animateWithDuration:coverViewDuration animations:^{
        coverViewValue.alpha = 0.0;
    } completion:^(BOOL finished) {
        coverViewValue.hidden = YES;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:CoverViewDidClickNoti object:nil];
}

@end
