//
//  STHomeViewController.m
//  Converter
//
//  Created by Shri on 28/07/14.
//  Copyright (c) 2014 Shri. All rights reserved.
//

#import "STHomeViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "ModalViewController.h"
#import "STBase62Converter.h"

#import <POP/POP.h>

#define kLabelWidth 215
#define kLabelHeight 20

@interface STHomeViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UILabel *enterNoLabel;
@property (nonatomic, weak) IBOutlet UILabel *generatedNoLabel;
@property (nonatomic, weak) IBOutlet UILabel *originalNoLabel;

@property (nonatomic, weak) IBOutlet UITextField *enterNoTextField;
@property (nonatomic, weak) IBOutlet UITextField *generatedNoTextField;
@property (nonatomic, weak) IBOutlet UITextField *originalNoTextField;

@property (nonatomic, weak) IBOutlet UIButton *convertButton;
-(IBAction) convertButtonPressed:(id) sender;
-(void) performInitialAnimations;

-(POPSpringAnimation *) springAnimationForView:(UIView *) view;
@end

@implementation STHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self performInitialAnimations];
}

- (void) performInitialAnimations {
  
  [self.view pop_addAnimation:[self springAnimationForView:self.view] forKey:@"ViewAnimation"];
  
 /*
  [self.enterNoLabel pop_addAnimation:[self springAnimationForView:self.enterNoLabel] forKey:@"enterNoLabelSpringAnimation"];
  [self.generatedNoLabel pop_addAnimation:[self springAnimationForView:self.generatedNoLabel] forKey:@"generateNoLabelSpringAnimation"];
  [self.originalNoLabel pop_addAnimation:[self springAnimationForView:self.originalNoLabel] forKey:@"originalNoLabelSpringAnimation"];
  
  [self.enterNoTextField pop_addAnimation:[self springAnimationForView:self.enterNoTextField] forKey:@"originalNoLabelSpringAnimation"];
  [self.generatedNoTextField pop_addAnimation:[self springAnimationForView:self.generatedNoTextField] forKey:@"originalNoLabelSpringAnimation"];
  [self.originalNoTextField pop_addAnimation:[self springAnimationForView:self.originalNoTextField] forKey:@"originalNoLabelSpringAnimation"];
*/

}

-(POPSpringAnimation *) springAnimationForView:(UIView *) view {
  POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
  basicAnimation.springBounciness=10;
  basicAnimation.springSpeed=4;
  
  basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
  basicAnimation.fromValue=[NSValue valueWithCGPoint:CGPointMake(300, view.center.y)];
  basicAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)];
  basicAnimation.name=@"NewAnimation";
  return basicAnimation;
}

- (void)shakeButton
{
  self.convertButton.userInteractionEnabled = NO;
  POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
  positionAnimation.velocity = @2000;
  positionAnimation.springBounciness = 20;
  [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
    self.convertButton.userInteractionEnabled = YES;
    if ([self.enterNoTextField.text length] == 0) {
      [self showModalView];
    }
    else {
      STBase62Converter *baseConverter = [[STBase62Converter alloc] init];
      NSString *generatedNo = [baseConverter getBase62FromDecimal:[self.enterNoTextField.text longLongValue]];
      self.generatedNoTextField.text = generatedNo;
      long long originalNo = [baseConverter getDecimalFromBase62:generatedNo];
      self.originalNoTextField.text = [NSString stringWithFormat:@"%lld", originalNo];
    }
  }];
  [self.convertButton.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

-(IBAction) convertButtonPressed:(id) sender {
  [self shakeButton];
}

-(void) showModalView {
  ModalViewController *modalViewController = [ModalViewController new];
  modalViewController.transitioningDelegate = self;
  modalViewController.modalPresentationStyle = UIModalPresentationCustom;
  
  [self.navigationController presentViewController:modalViewController
                                          animated:YES
                                        completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
  return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  return [DismissingAnimator new];
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
