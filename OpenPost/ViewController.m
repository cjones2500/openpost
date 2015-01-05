//
//  ViewController.m
//  OpenPost
//
//  Created by Christopher Jones on 01/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "ViewController.h"
#import "OPTransition.h"
#import <math.h>
#import "OPInfoView.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

// amount of pixels to be considered out of the view (hopefully this is enough...)
const float yScrollLimit= 70.0;
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
    [self setFirstInfoViewMoveOffAmount:self.view.frame.size.width + self.firstInfoSubView.frame.size.width + 1.0];
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
    [self.view addGestureRecognizer:scrollInfoViewRecognizer];
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    //Information common to all OPInfoViews
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    
    // Get the subviews of the view
    NSArray *allSubViews = [self.view subviews];
    
    // Array of the OPInfoView subviews
    NSMutableDictionary *yPosMoveForEachOPInfoView = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    // Return if there are no subviews
    if ([allSubViews count] == 0) return; // COUNT CHECK LINE
    
    //Given an integer label to each subview
    int iOPInfoView = 0;
    
    for (UIView *subview in allSubViews) {
        
        //Check to see if this is an OPInfoView class
        if ([subview isKindOfClass:[OPInfoView class]]){
            
            //work out how much to translate each subview
            CGRect updateFrame = subview.frame;
            CGFloat yPositionToMove = subview.frame.origin.y + 0.5*translation.y ;
            //if the scroll is above a certain level then stop the movement
            //if(yPositionToMove < yScrollLimit) yPositionToMove = yScrollLimit;
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
    
    [UIView animateWithDuration:0.3
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
                         
                         //[gestureRecognizer setTranslation:CGPointZero inView:self.view];
                     }
                     completion:^(BOOL finished){
                         //do nothing
    }];
    
    
}

- (void) infoSubViewSwipeRight{
    
    if(self.isFirstInfoViewInScreen){
        [self setOriginalFirstInfoViewXPosition:self.firstInfoSubView.frame.origin.x];
        [self animateSubView:self.firstInfoSubView toXCoord:firstInfoViewMoveOffAmount toYCoord:self.firstInfoSubView.frame.origin.y];
        [self setIsFirstInfoViewInScreen:NO];
    }
    else{
        float amountToMoveBack = originalFirstInfoViewXPosition;
        [self animateSubView:self.firstInfoSubView toXCoord:amountToMoveBack toYCoord:self.firstInfoSubView.frame.origin.y];
        [self setIsFirstInfoViewInScreen:YES];
    }
    
}

- (IBAction)toggleFirstInfoSubView:(id)sender {
    
    if(self.isFirstInfoViewInScreen){
        [self setOriginalFirstInfoViewXPosition:self.firstInfoSubView.frame.origin.x];  
        [self animateSubView:self.firstInfoSubView toXCoord:firstInfoViewMoveOffAmount toYCoord:self.firstInfoSubView.frame.origin.y];
        [self setIsFirstInfoViewInScreen:NO];
    }
    else{
        float amountToMoveBack = originalFirstInfoViewXPosition;
        [self animateSubView:self.firstInfoSubView toXCoord:amountToMoveBack toYCoord:self.firstInfoSubView.frame.origin.y];
        [self setIsFirstInfoViewInScreen:YES];
    }
    //move the sub view back again
    
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
}

-(void) animateSubView:(UIView*)viewToMove toXCoord:(float)xCoord toYCoord:(float)yCoord
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //animate to move to a given location
                         viewToMove.frame = CGRectMake(xCoord, yCoord, viewToMove.frame.size.width, viewToMove.frame.size.height);
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

@end
