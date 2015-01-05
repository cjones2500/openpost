//
//  OPTransition.m
//  OpenPost
//
//  Created by Christopher Jones on 01/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPTransition.h"

@implementation OPTransition

@synthesize isPresentTransition,
alphaValue;

-(id)init
{
    //automatically chooses a dismissal (if not specified)
    return [self initWithType:NO];
}

//override the normal init function with a different alphaValue
- (id)initWithType:(BOOL)aType{
    self = [super init];
    
    if (self) {
        //If this is a presenting transition
        if(aType == true){
            [self setAlphaValue:1.0];
            [self setIsPresentTransition:YES];
            
        }
        //If this is a dismissing transition
        else{
            [self setAlphaValue:0.0];
            [self setIsPresentTransition:NO];
            
        }
    }
    
    return self;
}


-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *nextViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * containerView = [transitionContext containerView];
    
    //establish a totally transparent secondViewController
    //nextViewController.view.alpha = alphaValue;
    //nextViewController.view.frame = containerView.bounds;
    
    
    if(isPresentTransition){
        //establish the transition to move right
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [containerView.layer addAnimation:transition forKey:nil];
        [containerView addSubview:nextViewController.view];
    }
    else{
        //establish the transition to move left
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [containerView.layer addAnimation:transition forKey:nil];
        [containerView addSubview:nextViewController.view];
    }

    [UIView animateWithDuration:0.01
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //nextViewController.view.alpha = alphaValue;
                     }
                     completion:^(BOOL finished){
                         [transitionContext completeTransition:YES];
                     }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.01;
}

@end
