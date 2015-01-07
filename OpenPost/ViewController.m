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

// amount of pixels to be considered out of the view (hopefully this is enough...)
const float firstInfoSubViewYOrigin = 400.0;

/*TODO: Add the decoder and coder methods for:
- originalFirstInfoViewXPosition
- firstInfoSubView
 */

/*TODO: Different subViewOffScreen amounts for different types of machine*/

//TODO: Add a different maximum and minumum to each OPInfoView

@synthesize originalFirstInfoViewXPosition,
firstInfoSubView,
firstInfoViewMoveOffAmount;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view sendSubviewToBack:self.mainBkgView];
    
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
    self.customScrollView.scrollHorizontal = NO;
    
    UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0, 50.0, 190.0, 190.0)];
    UIImageView *redView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0, 660.0, 190.0, 190.0)];

    //setup the image
    UIImage * anImageObj;
    anImageObj = [UIImage imageNamed:@"barca.jpg"];
    [redView setImage:anImageObj];
    [redView2 setImage:anImageObj];
    
    
    //[self.customScrollView addSubview:redView];
    [self.customScrollView addSubview:redView2];
    [self.view addSubview:redView];
    
    [self.view addSubview:self.customScrollView];
    //make sure bring to front is called after the fact
    [self.view bringSubviewToFront:redView];
    
    /*OPInfoView * firstOPInfoView = [[OPInfoView alloc] initWithYCoord:100.0 withSuperView:self.view withAnImageNamed:@"barca.jpg"];
    [self.view addSubview:firstOPInfoView];
    [self.view addSubview:self.customScrollView];*/
    
    /*[self setFirstInfoViewMoveOffAmount:self.view.frame.size.width + self.firstInfoSubView.frame.size.width + 1.0];
    [self setIsFirstInfoViewInScreen:YES];
    
    //set the frame of the first subRubInfoView
    CGRect currentFirstSubViewInfoFrame = self.firstInfoSubView.frame;
    currentFirstSubViewInfoFrame.origin.y = firstInfoSubViewYOrigin;
    self.firstInfoSubView.frame = currentFirstSubViewInfoFrame;
    
    OPInfoView * firstOPInfoView = [[OPInfoView alloc] initWithYCoord:100.0 withSuperView:self.view withAnImageNamed:@"barca.jpg"];
    [self.view addSubview:firstOPInfoView];
    
    OPInfoView * secondOPInfoView = [[OPInfoView alloc] initWithYCoord:800.0 withSuperView:self.view withAnImageNamed:@"barca.jpg"];
    [self.view addSubview:secondOPInfoView];

    OPInfoView * thirdOPInfoView = [[OPInfoView alloc] initWithYCoord:1600.0 withSuperView:self.view withAnImageNamed:@"barca.jpg"];
    [self.view addSubview:thirdOPInfoView];
    
    UIPanGestureRecognizer *scrollInfoViewRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:scrollInfoViewRecognizer];*/
    
}

/*- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    [self animateInfoViewsInSuperView:self.view forPanGesture:gestureRecognizer];
}*/

-(void) animateInfoViewsInSuperView:(UIView*)aSuperView forPanGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    //Information common to all OPInfoViews
    CGPoint translation = [gestureRecognizer translationInView:aSuperView];
    
    //Limit the size of the translation
    if(translation.y > 700.0) translation.y = 700.0;
    else if (translation.y < -700.0) translation.y = -700.0;
    else {
        //do nothing
    }
    
    NSLog(@"translation size %f",translation.y);
    
    // Get the subviews of the view
    NSArray *allSubViews = [aSuperView subviews];
    
    // Array of the OPInfoView subviews
    NSMutableDictionary *yPosMoveForEachOPInfoView = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    // Return if there are no subviews
    if ([allSubViews count] == 0) return; // COUNT CHECK LINE
    
    //Given an integer label to each subview
    int iOPInfoView = 0;
    
    for (OPInfoView *subview in allSubViews) {
        
        //Check to see if this is an OPInfoView class
        if ([subview isKindOfClass:[OPInfoView class]]){
    
            //work out how much to translate each subview
            CGRect updateFrame = subview.frame;
            CGFloat yPositionToMove = subview.frame.origin.y + translation.y ;
            
            
            updateFrame.origin.y = yPositionToMove;
            
            //recast as a NSNumber
            NSNumber * yPosToMoveObj = [NSNumber numberWithFloat:yPositionToMove];
            
            //label each OPInfoSubVIew
            NSString * subViewLabel = [NSString stringWithFormat:@"%i",iOPInfoView];
            
            //add to each translation to the mutable dictionary
            [yPosMoveForEachOPInfoView setObject:yPosToMoveObj forKey:subViewLabel];
            
            //increment the labelling of the OPInfoSubView
            iOPInfoView = iOPInfoView + 1;
        }
    }
    
    //loop through all the subViews and animate all OPInfoSubviews
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //Given an integer label to each subview
                         int iOPInfoView = 0;
                         //Loop through all the subviews
                         for (UIView *subview in allSubViews) {
                             //Check to see if this is an OPInfoView class
                             if ([subview isKindOfClass:[OPInfoView class]]){
                                 
                                 //fetch the correct translation
                                 NSString * subViewLabel = [NSString stringWithFormat:@"%i",iOPInfoView];
                                 float yPostion = [[yPosMoveForEachOPInfoView objectForKey:subViewLabel] floatValue];
                                 
                                 //update the subview with its new frame
                                 subview.frame = CGRectMake(subview.frame.origin.x
                                                            , yPostion, subview.frame.size.width, subview.frame.size.width);
                                 iOPInfoView = iOPInfoView + 1;
                             }
                         }
                         
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
    
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
