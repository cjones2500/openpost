//
//  OPButtonView.m
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPButtonView.h"

@implementation OPButtonView

@synthesize OPButtonViewHeight,
OPButtonViewWidth;

- (id)initWithYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView
{
    float widthOfButtonView = 0.9*aSuperView.frame.size.width;
    [self setOPButtonViewHeight:40.0];
    [self setOPButtonViewWidth:widthOfButtonView];
    
    //find the middle of the superView
    float middleOfSuperView = aSuperView.frame.size.width/2.0;
    float xPlacementInSuperView = middleOfSuperView - OPButtonViewWidth/2.0 - 2.0;
    
    CGRect frame = CGRectMake(xPlacementInSuperView, yCoord, OPButtonViewWidth, OPButtonViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    
    [self formatButtonView];
    
    return self;
}

-(void) formatButtonView
{
    UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
    self.backgroundColor = OPColour;
    self.layer.cornerRadius = self.frame.size.width/90.0;
    self.layer.masksToBounds = YES;
}

-(void) placeButtonInViewWithYPos:(CGFloat)aYPos withPercentageWidth:(float)aPercentageWidth
{
    //do nothing
}

@end
