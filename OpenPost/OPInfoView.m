//
//  OPInfoView.m
//  OpenPost
//
//  Created by Christopher Jones on 04/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPInfoView.h"
#import <POP.h> 

@implementation OPInfoView

@synthesize OPInfoViewHeight,
OPInfoViewWidth,
OPInfoViewGesture,
OPSuperView,
OPInfoViewYMax,
OPInfoViewYMin;

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
    //setup the image
    UIImage * anImageObj;
    anImageObj = [UIImage imageNamed:anImage];
    [self setImage:anImageObj];
}


@end
