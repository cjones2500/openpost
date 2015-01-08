//
//  SignUpVC.m
//  OpenPost
//
//  Created by Christopher Jones on 08/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "SignUpVC.h"
#import "OPLogo.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self removeLogo:logo withBkg:bkg];
        });
    });
}

-(void) removeLogo:(OPLogo*)aLogo withBkg:(UIImageView*)abkg
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         aLogo.alpha = 0.0;
                         abkg.alpha = 0.0; // remove the background as well
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
