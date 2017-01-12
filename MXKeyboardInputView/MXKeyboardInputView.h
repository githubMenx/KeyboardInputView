//
//  KeyboardInputView.h
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MXKeyboardInputView;

@protocol MXKeyboardInputViewDelegate <NSObject>

- (void)keyboardInputViewDidClickConfirm:(MXKeyboardInputView *)keyboardInputView text:(NSString *)text;

@end

@interface MXKeyboardInputView : UIView

@property (nonatomic, weak) id<MXKeyboardInputViewDelegate> delegate;

+ (instancetype)keyboardInputView;

- (void)showInViewController:(UIViewController *)viewController;

@end
