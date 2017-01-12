//
//  CoverView.h
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const MXCoverViewDidClickNoti = @"MXCoverViewDidClickNoti";

@interface MXCoverView : UIView

+ (void)showInViewController:(UIViewController *)viewController;

+ (void)hideInViewController:(UIViewController *)viewController;

@end
