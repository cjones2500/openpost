//
//  SecondViewController.m
//  OpenPost
//
//  Created by Christopher Jones on 02/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "LoginVC.h"
#import "OPTransition.h"

@interface LoginVC () <UIViewControllerTransitioningDelegate>

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add a Tap Gesture to close View Controller
    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tapToDismiss];
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
