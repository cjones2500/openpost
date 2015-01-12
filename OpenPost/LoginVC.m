//
//  SecondViewController.m
//  OpenPost
//
//  Created by Christopher Jones on 02/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "LoginVC.h"
#import "OPTransition.h"
#import "OPButton.h"
#import "OPTextField.h"
#import <FacebookSDK.h>

@interface LoginVC () <UIViewControllerTransitioningDelegate>

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //create the submit button
    float submitButtonWidth = 1.0*self.view.frame.size.width;
    float submitButtonXPosition = 0.0;//0.2*0.7*self.view.frame.size.width;
    float submitButtonHeight = 0.1*self.view.frame.size.height;
    float submitButtonYPosition = 0.0;
    CGRect submitButtonFrame = CGRectMake(submitButtonXPosition, submitButtonYPosition, submitButtonWidth, submitButtonHeight);
    OPButton* proceedButton = [[OPButton alloc] initWithFrame:submitButtonFrame withTitle:@"Login"];
    [self.view addSubview:proceedButton];
    
    
    //add Facebook login window
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    float loginViewYPos = 0.15*self.view.frame.size.height;
    float loginViewWidth = 0.8*self.view.frame.size.width;
    float loginVIewXPos = 0.09*self.view.frame.size.width;
    CGRect fbLoginFrame = CGRectMake(loginVIewXPos, loginViewYPos, loginViewWidth, submitButtonHeight);
    loginView.frame = fbLoginFrame;
    [self.view addSubview:loginView];
    
    //build the go back button
    float backButtonWidth = 0.2*self.view.frame.size.width;
    float backButtonXPosition = 0.0;//0.2*0.7*self.view.frame.size.width;
    float backButtonHeight = 0.05*self.view.frame.size.height;
    float backButtonYPosition = 0.035*self.view.frame.size.height;//0.7*self.view.frame.size.height - submitButtonHeight;
    CGRect backButtonFrame = CGRectMake(backButtonXPosition, backButtonYPosition, backButtonWidth, backButtonHeight);
    OPButton* backButton = [[OPButton alloc] initWithFrame:backButtonFrame withTitle:@"Back"];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17.0]];
    [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //add UILabel for the OR
    CGRect orLabelFrame = CGRectMake(0.45*self.view.frame.size.width,
                                     0.25*self.view.frame.size.height,
                                     0.33*self.view.frame.size.width,
                                     0.1*self.view.frame.size.height);
    UILabel * orLabel = [[UILabel alloc] initWithFrame:orLabelFrame];
    [orLabel setText:@"OR"];
    [orLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]];
    [self.view addSubview:orLabel];
    
    //add an email TextField
    CGRect emailTfFrame = CGRectMake(0.09*self.view.frame.size.width,
                                     0.35*self.view.frame.size.height,
                                     0.8*self.view.frame.size.width,
                                     0.1*self.view.frame.size.height);
    OPTextField* emailField = [[OPTextField alloc] initWithFrame:emailTfFrame withTitle:@"Email:" isSecure:NO];
    [self.view addSubview:emailField];
    
    //add a password field
    CGRect passwordTfFrame = CGRectMake(0.09*self.view.frame.size.width,
                                        0.5*self.view.frame.size.height,
                                        0.8*self.view.frame.size.width,
                                        0.1*self.view.frame.size.height);
    OPTextField* passwordField = [[OPTextField alloc] initWithFrame:passwordTfFrame withTitle:@"Password:" isSecure:YES];
    [self.view addSubview:passwordField];

}

- (void)close {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    @try {
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        viewController.transitioningDelegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Error thrown attempting to initialise second view: %@\n",exception);
    }
    
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Transition Delegate Required Method
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OPTransition alloc] initWithType:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
