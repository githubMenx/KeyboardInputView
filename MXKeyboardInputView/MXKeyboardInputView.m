//
//  KeyboardInputView.m
//  KeyboardInputView
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "MXKeyboardInputView.h"
#import "MXCoverView.h"

@interface MXKeyboardInputView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MXKeyboardInputView

#pragma mark - 初始化

- (void)awakeFromNib {
    [super awakeFromNib];
    // 监听键盘的弹起和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 监听蒙版的点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coverDidClick) name:MXCoverViewDidClickNoti object:nil];
}

+ (instancetype)keyboardInputView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MXKeyboardInputView class]) owner:nil options:nil] firstObject];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat y = [UIScreen mainScreen].bounds.size.width;
        self.frame = CGRectMake(0, y, width, 80);
    }
    return self;
}

#pragma mark - 公开方法

- (void)showInViewController:(UIViewController *)viewController {
    // 添加蒙版
    [MXCoverView showInViewController:viewController];
    if (!viewController.navigationController.view) {
        NSLog(@"warning! viewController.navigationController.view is null");
        return;
    }
    // 添加self
    [viewController.navigationController.view addSubview:self];
    // 成为第一响应者
    [self.textField becomeFirstResponder];
}

#pragma mark - 内部方法

- (void)hideInViewController:(UIViewController *)viewController {
    // 隐藏蒙版
    [MXCoverView hideInViewController:viewController];
    // 失去第一响应者
    [self.textField resignFirstResponder];
}

#pragma mark - click

- (IBAction)confirmAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardInputViewDidClickConfirm:text:)]) {
        [self hideInViewController:(UIViewController *)self.delegate];
        [self.delegate keyboardInputViewDidClickConfirm:self text:self.textField.text];
    }
}

#pragma mark - notification

- (void)coverDidClick {
    if (self.delegate) {
        [self hideInViewController:(UIViewController *)self.delegate];
    }
}

- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect myFrame = self.frame;
        myFrame.origin.y = keyboardFrame.origin.y - myFrame.size.height;
        self.frame = myFrame;
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect myFrame = self.frame;
        myFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = myFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
