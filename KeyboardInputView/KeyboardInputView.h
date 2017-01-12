//
//  KeyboardInputView.h
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardInputView;

@protocol KeyboardInputViewDelegate <NSObject>

- (void)keyboardInputViewDidClickConfirm:(KeyboardInputView *)keyboardInputView text:(NSString *)text;

@end

@interface KeyboardInputView : UIView

@property (nonatomic, weak) id<KeyboardInputViewDelegate> delegate;

+ (instancetype)keyboardInputView;

- (void)showInViewController:(UIViewController *)viewController;

- (void)hideInViewController:(UIViewController *)viewController;

@end
