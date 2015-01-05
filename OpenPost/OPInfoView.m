//
//  OPInfoView.m
//  OpenPost
//
//  Created by Christopher Jones on 04/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPInfoView.h"

@implementation OPInfoView

const float yTopScrollLimit= 70.0;

@synthesize OPInfoViewHeight,
OPInfoViewWidth,
OPInfoViewGesture,
OPSuperView;

- (id)initWithYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage
{
    //default to using 190 for both the height and width
    [self setOPInfoViewHeight:190];
    [self setOPInfoViewWidth:190];
    [self setOPSuperView:aSuperView];
    
    //find the middle of the superView
    float middleOfSuperView = aSuperView.frame.size.width/2.0;
    float xPlacementInSuperView = middleOfSuperView - OPInfoViewWidth/2.0;
    
    CGRect frame = CGRectMake(xPlacementInSuperView, yCoord, OPInfoViewWidth, OPInfoViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self initOPInfoViewWithImage:anImage];
    return self;
}

- (id)initWithXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage
{
    //default to using 190 for both the height and width
    [self setOPInfoViewHeight:190];
    [self setOPInfoViewWidth:190];
    [self setOPSuperView:aSuperView];
    
    CGRect frame = CGRectMake(xCoord, yCoord, OPInfoViewWidth, OPInfoViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self initOPInfoViewWithImage:anImage];
    return self;
}

- (id)initWithXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withWidth:(float)aWidth withHeight:(float)aHeight withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage
{
    [self setOPInfoViewHeight:aHeight];
    [self setOPInfoViewWidth:aWidth];
    [self setOPSuperView:aSuperView];
    
    CGRect frame = CGRectMake(xCoord, yCoord, OPInfoViewWidth, OPInfoViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self initOPInfoViewWithImage:anImage];
    return self;
}

-(void) initOPInfoViewWithImage:(NSString*)anImage
{
    //set the image
    UIImage * anImageObj;
    anImageObj = [UIImage imageNamed:anImage];
    [self setImage:anImageObj];
    
    //create a gesture recognizer
    /*UIPanGestureRecognizer *scrollInfoViewRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self action:@selector(handlePanGesture:)];
    [self.OPSuperView addGestureRecognizer:scrollInfoViewRecognizer];*/
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self];
    CGRect currentFrame = self.frame;
    CGFloat yPositionToMove = self.frame.origin.y + 2.0*translation.y ;
    
    //if the scroll is above a certain level then stop the movement
    if(yPositionToMove < yTopScrollLimit) yPositionToMove = yTopScrollLimit;
    
    
    //limit how far in the xDirectionToMove to be less than 4x view frame
    /*if( xDirectionToMove > 4.0*self.view.frame.origin.x){
     xDirectionToMove = 4.0*self.view.frame.origin.x;
     }
     else if (xDirectionToMove < -4.0*self.view.frame.origin.x){
     xDirectionToMove = -4.0*self.view.frame.origin.x;
     }
     else{
     //do nothing
     }*/
    
    currentFrame.origin.y = yPositionToMove;
    
    /*self.firstInfoSubView.frame = currentFrame;
     [gestureRecognizer setTranslation:CGPointZero inView:self.view];*/
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //animate to move to a given location
                         self.frame = currentFrame;
                         [gestureRecognizer setTranslation:CGPointZero inView:self];
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
    
    
}

@end
