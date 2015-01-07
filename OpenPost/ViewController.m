//
//  ViewController.m
//  OpenPost
//
//  Created by Christopher Jones on 01/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//
#import "CustomScrollView.h"
#import "ViewController.h"
#import "OPTransition.h"
#import <math.h>
#import "OPInfoView.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) CustomScrollView *customScrollView;

@end

@implementation ViewController

/*TODO: Add the decoder and coder methods for:
- originalFirstInfoViewXPosition
- firstInfoSubView
 */

/*TODO: Different subViewOffScreen amounts for different types of machine*/

//TODO: Add a different maximum and minumum to each OPInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add Background view
    [self.view sendSubviewToBack:self.mainBkgView];
    
    //initialise the customScrollView
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 2000.0);
    self.customScrollView.scrollHorizontal = NO;
    
    //y positions of all the different views
    float firstOPInfoViewYPos = 150.0;
    float secondOPInfoViewYPos = firstOPInfoViewYPos + self.customScrollView.frame.size.height;
    float thirdOPInfoViewYPos = secondOPInfoViewYPos + self.customScrollView.frame.size.height;
    
    //create all InfoViews
    OPInfoView * firstOPInfoView = [[OPInfoView alloc] initWithYCoord:firstOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
     [self.customScrollView addSubview:firstOPInfoView];

    OPInfoView * secondOPInfoView = [[OPInfoView alloc] initWithYCoord:secondOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
    [self.customScrollView addSubview:secondOPInfoView];
    
    OPInfoView * thirdOPInfoView = [[OPInfoView alloc] initWithYCoord:thirdOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
    [self.customScrollView addSubview:thirdOPInfoView];
    
    [self.view addSubview:self.customScrollView];
}

#pragma mark - Transition Delegate Required Method
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OPTransition alloc] initWithType:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///KEEP FOR REFERENCE
///Helpful for transitioning to a different view after confirmation
/*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 @try {
 UIViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
 secondViewController.modalPresentationStyle = UIModalPresentationCustom;
 secondViewController.transitioningDelegate = self;
 [self presentViewController:secondViewController animated:YES completion:nil];
 }
 @catch (NSException *exception) {
 NSLog(@"Error thrown attempting to initialise second view: %@\n",exception);
 }*/

@end
