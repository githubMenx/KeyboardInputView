//
//  CoverView.m
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "MXCoverView.h"
#import <objc/runtime.h>

static const char MXCoverViewKey = '\0';
static const double MXCoverViewDuration = 0.25;

@implementation MXCoverView

+ (void)showInViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    // 利用runtime从控制器中取出coverViewKey
    MXCoverView *coverViewValue = objc_getAssociatedObject(viewController, &MXCoverViewKey);
    // 如果没有就创建并利用runtime给该控制器添加属性coverViewKey
    if (!coverViewValue) {
        MXCoverView *coverView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MXCoverView class]) owner:nil options:nil] firstObject];
        coverView.frame = viewController.view.bounds;
        coverView.alpha = 0.0;
        if (!viewController.navigationController.view) {
            NSLog(@"warning! viewController.navigationController.view is null");
            return;
        }
        [viewController.navigationController.view addSubview:coverView];
        objc_setAssociatedObject(viewController, &MXCoverViewKey, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        coverViewValue = coverView;
    }
    // 执行动画
    coverViewValue.hidden = NO;
    [UIView animateWithDuration:MXCoverViewDuration animations:^{
        coverViewValue.alpha = 1.0;
    }];
}

+ (void)hideInViewController:(UIViewController *)viewController {
    MXCoverView *coverViewValue = objc_getAssociatedObject(viewController, &MXCoverViewKey);
    // 执行动画
    [UIView animateWithDuration:MXCoverViewDuration animations:^{
        coverViewValue.alpha = 0.0;
    } completion:^(BOOL finished) {
        coverViewValue.hidden = YES;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:MXCoverViewDidClickNoti object:nil];
}

@end
