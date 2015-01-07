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
#import "OPInfoView.h"
#import "OPTextInfoView.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) CustomScrollView *customScrollView;

@end

@implementation ViewController

/*TODO: Coder and Decoder initialisations of all Objects in the view*/

/*TODO: Currently hardcorded the yPosition of the first OPInfoView, this makes it difficult ot use on different platforms */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add Background view
    [self.view sendSubviewToBack:self.mainBkgView];
    
    //set the maximum size of the view for 3 subviews
    float maxmimumScollLength = 3.0*self.view.frame.size.height;
    
    //initialise the customScrollView
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, maxmimumScollLength);
    self.customScrollView.scrollHorizontal = NO;
    
    //y positions of all the different views
    float firstOPInfoViewYPos = 0.5*self.view.frame.size.height - 120.0; //NOTE:hardcorded the center of the first view
    float secondOPInfoViewYPos = firstOPInfoViewYPos + self.customScrollView.frame.size.height;
    float thirdOPInfoViewYPos = secondOPInfoViewYPos + self.customScrollView.frame.size.height;
    
    //create all InfoViews
    OPInfoView * firstOPInfoView = [[OPInfoView alloc] initWithYCoord:firstOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
     [self.customScrollView addSubview:firstOPInfoView];

    OPInfoView * secondOPInfoView = [[OPInfoView alloc] initWithYCoord:secondOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
    [self.customScrollView addSubview:secondOPInfoView];
    
    OPInfoView * thirdOPInfoView = [[OPInfoView alloc] initWithYCoord:thirdOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
    [self.customScrollView addSubview:thirdOPInfoView];
    
    //Create all primary Text Views
    OPTextInfoView * firstTextInfoView = [[OPTextInfoView alloc] initWithSuperView:self.customScrollView withText:@"SEND PACKAGES ANYWHERE, ANYTIME" linkedToInfoView:firstOPInfoView];
    [self.customScrollView addSubview:firstTextInfoView];
    
    OPTextInfoView * secondTextInfoView = [[OPTextInfoView alloc] initWithSuperView:self.customScrollView withText:@"PAY ON DELIVERY" linkedToInfoView:secondOPInfoView];
    [self.customScrollView addSubview:secondTextInfoView];
    
    OPTextInfoView * thirdTextInfoView = [[OPTextInfoView alloc] initWithSuperView:self.customScrollView withText:@"REVIEW YOUR COURIER" linkedToInfoView:thirdOPInfoView];
    [self.customScrollView addSubview:thirdTextInfoView];
    
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
