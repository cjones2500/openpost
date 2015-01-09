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
    float submitButtonWidth = 0.7*self.view.frame.size.width;
    float submitButtonXPosition = 0.2*0.7*self.view.frame.size.width;
    float submitButtonHeight = 0.1*self.view.frame.size.height;
    float submitButtonYPosition = 0.7*self.view.frame.size.height - submitButtonHeight;
    CGRect submitButtonFrame = CGRectMake(submitButtonXPosition, submitButtonYPosition, submitButtonWidth, submitButtonHeight);
    OPButton* proceedButton = [[OPButton alloc] initWithFrame:submitButtonFrame withTitle:@"Join the Revolution!"];
    [self.view addSubview:proceedButton];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.FBUtility localizedStringForKey:@"FBLV:LogOutButton" withDefault:@"Log out"];
    float loginViewYPos = 0.5*self.view.frame.size.height - submitButtonHeight;
    CGRect fbLoginFrame = CGRectMake(submitButtonXPosition, loginViewYPos, submitButtonWidth, submitButtonHeight);
    loginView.frame = fbLoginFrame;
    [self.view addSubview:loginView];
    
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
