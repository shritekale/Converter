//
//  STMainViewController.m
//  Converter
//
//  Created by Shri on 27/07/14.
//  Copyright (c) 2014 Shri. All rights reserved.
//

#import "STMainViewController.h"
#import "PasswordStrengthIndicatorView.h"

@interface STMainViewController ()
@property(nonatomic) UITextField *numberTextField;
@property(nonatomic) PasswordStrengthIndicatorView *passwordStrengthIndicatorView;
- (void)addnumberTextField;
- (void)addPasswordStrengthView;
- (void)textFieldDidChange:(UITextField *)sender;
@end

@implementation STMainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addnumberTextField];
  [self addPasswordStrengthView];
}

#pragma mark - Private Interface methods

- (void)addnumberTextField
{
  UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
  
  self.numberTextField = [UITextField new];
  self.numberTextField.leftView = leftPaddingView;
  self.numberTextField.leftViewMode = UITextFieldViewModeAlways;
  self.numberTextField.translatesAutoresizingMaskIntoConstraints = NO;
  self.numberTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
  self.numberTextField.layer.cornerRadius = 2.f;
  self.numberTextField.placeholder = @"Enter a Number";
  self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
  [self.numberTextField becomeFirstResponder];
  [self.numberTextField addTarget:self
                             action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
  [self.view addSubview:self.numberTextField];
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_numberTextField);
  
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-[_numberTextField]-|"
                             options:0
                             metrics:nil
                             views:views]];
  
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:|-(88)-[_numberTextField(==36)]"
                             options:0
                             metrics:nil
                             views:views]];
}

- (void)addPasswordStrengthView
{
  self.passwordStrengthIndicatorView = [PasswordStrengthIndicatorView new];
  [self.view addSubview:self.passwordStrengthIndicatorView];
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_numberTextField, _passwordStrengthIndicatorView);
  
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-[_passwordStrengthIndicatorView]-|"
                             options:0
                             metrics:nil
                             views:views]];
  
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:[_numberTextField]-[_passwordStrengthIndicatorView(==10)]"
                             options:0
                             metrics:nil
                             views:views]];
}

- (void)textFieldDidChange:(UITextField *)sender
{
  if (sender.text.length < 1) {
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusNone;
    return;
  }
  
  if (sender.text.length < 5) {
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusWeak;
    return;
  }
  
  if (sender.text.length < 10) {
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusFair;
    return;
  }
  
  self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusStrong;
}

@end
