//
//  ViewController.m
//  MXKeyboardInputViewExample
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "ViewController.h"
#import "MXKeyboardInputView.h"

@interface ViewController () <MXKeyboardInputViewDelegate>

@property (nonatomic, strong) MXKeyboardInputView *keyboardInputView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (MXKeyboardInputView *)keyboardInputView {
    if (!_keyboardInputView) {
        _keyboardInputView = [MXKeyboardInputView keyboardInputView];
        _keyboardInputView.delegate = self;
    }
    return _keyboardInputView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)showInputView:(id)sender {
    [self.keyboardInputView showInViewController:self];
}


#pragma mark - KeyboardInputViewDelegate

- (void)keyboardInputViewDidClickConfirm:(MXKeyboardInputView *)keyboardInputView text:(NSString *)text {
    self.label.text = text;
}

@end
