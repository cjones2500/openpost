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
#import "OPButtonView.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) CustomScrollView *customScrollView;

@end

@implementation ViewController

/*TODO: Coder and Decoder initialisations of all Objects in the view*/

/*TODO: Currently hardcorded the yPosition of the first OPInfoView, this makes it difficult ot use on different platforms */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //total number of subview in this ViewController
    float totalNumberOfSubViews = 3.0;
    
    //add Background view
    [self.view sendSubviewToBack:self.mainBkgView];
    
    //add the Control Button view
    OPButtonView* controlButtonsView = [[OPButtonView alloc] initWithYCoord:40.0 withSuperView:self.view];
    
    //NOTE: The order of adding subviews affects which has priority in what you see
    
    //add a Login Button into the Control Button View
    [controlButtonsView placeButtonInViewWithXPos:0.0 withPercentageWidth:50.0 withTitle:@"Login"];
    [self.view addSubview:controlButtonsView];
    SEL onClickSelector = @selector(onClickLogin);
    [controlButtonsView addTargetToButtonWithTitle:@"Login" withFunction:onClickSelector fromObject:self];
    
    //add actions to the differentButtons
    
    
    //add a SignUp Button into the Control Button View
    [controlButtonsView placeButtonInViewWithXPos:0.5*controlButtonsView.frame.size.width withPercentageWidth:50.0 withTitle:@"Sign Up"];
    [self.view addSubview:controlButtonsView];
    
    //add a line between the two Control Buttons in the Control Button View
    [controlButtonsView placeHorizontalLineInViewWithXCoord:controlButtonsView.frame.size.width*0.5];
    
    //set the maximum size of the view for 3 subviews
    float maxmimumScollLength = totalNumberOfSubViews*self.view.frame.size.height;
    
    //initialise the customScrollView
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, maxmimumScollLength);
    self.customScrollView.scrollHorizontal = NO;
    
    //y positions of all the different views
    float firstOPInfoViewYPos = 0.5*self.view.frame.size.height - 120.0; //NOTE:hardcorded the center of the first view
    float secondOPInfoViewYPos = firstOPInfoViewYPos + self.customScrollView.frame.size.height;
    float thirdOPInfoViewYPos = secondOPInfoViewYPos + self.customScrollView.frame.size.height;
    
    //create all InfoViews
    OPInfoView * firstOPInfoView = [[OPInfoView alloc] initWithYCoord:firstOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"mapshot.png"];
     [self.customScrollView addSubview:firstOPInfoView];

    OPInfoView * secondOPInfoView = [[OPInfoView alloc] initWithYCoord:secondOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"mapshot.png"];
    [self.customScrollView addSubview:secondOPInfoView];
    
    OPInfoView * thirdOPInfoView = [[OPInfoView alloc] initWithYCoord:thirdOPInfoViewYPos withSuperView:self.customScrollView withAnImageNamed:@"barca.jpg"];
    [self.customScrollView addSubview:thirdOPInfoView];
    
    //Create all primary Text Views
    OPTextInfoView * firstTextInfoView = [[OPTextInfoView alloc] initOPTextViewWithSuperView:self.customScrollView withText:@"SEND PACKAGES ANYWHERE, ANYTIME" linkedToInfoView:firstOPInfoView withTextFontSize:17.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:firstTextInfoView];
    
    OPTextInfoView * secondTextInfoView = [[OPTextInfoView alloc] initOPTextViewWithSuperView:self.customScrollView withText:@"TRACK AND PAY" linkedToInfoView:secondOPInfoView withTextFontSize:17.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:secondTextInfoView];
    
    OPTextInfoView * thirdTextInfoView = [[OPTextInfoView alloc] initOPTextViewWithSuperView:self.customScrollView withText:@"REVIEW YOUR COURIER" linkedToInfoView:thirdOPInfoView withTextFontSize:17.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:thirdTextInfoView];
    
    //Create all secondary Text Views
    OPTextInfoView * firstSubTextInfoView = [[OPTextInfoView alloc] initOPTextSubViewWithSuperView:self.customScrollView withText:@"OpenPost picks up and sends packages from any location" linkedToTextInfoView:firstTextInfoView withTextFontSize:16.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:firstSubTextInfoView];
    
    OPTextInfoView * secondSubTextInfoView = [[OPTextInfoView alloc] initOPTextSubViewWithSuperView:self.customScrollView withText:@"Track your package all the way. Pay on Delivery" linkedToTextInfoView:secondTextInfoView withTextFontSize:16.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:secondSubTextInfoView];
    
    OPTextInfoView * thirdSubTextInfoView = [[OPTextInfoView alloc] initOPTextSubViewWithSuperView:self.customScrollView withText:@"Rate your courier and improve the Open Post experience" linkedToTextInfoView:thirdTextInfoView withTextFontSize:16.0 withFontType:@"HelveticaNeue-Thin"];
    [self.customScrollView addSubview:thirdSubTextInfoView];
    
    [self.view addSubview:self.customScrollView];
    
    //bring the Login Button View to the front
    [self.view bringSubviewToFront:controlButtonsView];
    
}

- (void) onClickLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    @try {
        UIViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
        secondViewController.modalPresentationStyle = UIModalPresentationCustom;
        secondViewController.transitioningDelegate = self;
        [self presentViewController:secondViewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Error thrown attempting to initialise second view: %@\n",exception);
    }
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
