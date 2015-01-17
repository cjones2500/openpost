//
//  SignUpVC.m
//  OpenPost
//
//  Created by Christopher Jones on 08/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "SignUpVC.h"
#import "OPLogo.h"
#import "OPButton.h"
#import <FacebookSDK/FacebookSDK.h>
#import "OPTextField.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildSignUpView]; // buildBasicView
    
    //add Logo
    __block OPLogo* logo = [[OPLogo alloc] initWithFrame:self.view.frame];
    __block UIImageView * bkg = [[UIImageView alloc] initWithFrame:logo.frame];
    UIImage* anImageObj = [UIImage imageNamed:@"barca2.jpg"];
    [bkg setImage:anImageObj];
    [self.view addSubview:bkg];
    [self.view sendSubviewToBack:bkg];
    [self.view addSubview:logo];
    logo.alpha = 0.0;
    
    //Play around with the Logo appearing and dissappearing
    
    //toggle showing the logo 
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(0.0, dispatch_get_main_queue(), ^(void){
        [self addLogo:logo];
        //dispatch_sync(dispatch_get_main_queue(), ^(void){
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self removeLogo:logo withBkg:bkg];
        });
    });
}

-(void) buildSignUpView
{
    //create the submit button
    float submitButtonWidth = 1.0*self.view.frame.size.width;
    float submitButtonXPosition = 0.0;//0.2*0.7*self.view.frame.size.width;
    float submitButtonHeight = 0.1*self.view.frame.size.height;
    float submitButtonYPosition = 0.0;
    CGRect submitButtonFrame = CGRectMake(submitButtonXPosition, submitButtonYPosition, submitButtonWidth, submitButtonHeight);
    OPButton* proceedButton = [[OPButton alloc] initWithFrame:submitButtonFrame withTitle:@"Sign Up"];
    proceedButton.layer.cornerRadius = 0.0;
    [self.view addSubview:proceedButton];
    
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
    
    //add Facebook login window
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    float loginViewYPos = 0.15*self.view.frame.size.height;
    float loginViewWidth = 0.8*self.view.frame.size.width;
    float loginVIewXPos = 0.09*self.view.frame.size.width;
    CGRect fbLoginFrame = CGRectMake(loginVIewXPos, loginViewYPos, loginViewWidth, submitButtonHeight);
    loginView.frame = fbLoginFrame;
    [self.view addSubview:loginView];
    
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


-(void) removeLogo:(OPLogo*)aLogo withBkg:(UIImageView*)abkg
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         aLogo.alpha = 0.0;
                         //abkg.alpha = 0.0; // remove the background as well
                     }
                     completion:^(BOOL finished){
                         //do nothing
    }];
}

-(void) addLogo:(OPLogo*)aLogo
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         aLogo.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
