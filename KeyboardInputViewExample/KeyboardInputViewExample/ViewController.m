//
//  ViewController.m
//  KeyboardInputViewExample
//
//  Created by Meng on 17/1/12.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardInputView.h"

@interface ViewController () <KeyboardInputViewDelegate>

@property (nonatomic, strong) KeyboardInputView *keyboardInputView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (KeyboardInputView *)keyboardInputView {
    if (!_keyboardInputView) {
        _keyboardInputView = [KeyboardInputView keyboardInputView];
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

- (void)keyboardInputViewDidClickConfirm:(KeyboardInputView *)keyboardInputView text:(NSString *)text {
    self.label.text = text;
}


@end
