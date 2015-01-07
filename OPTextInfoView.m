//
//  OPTextInfoView.m
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPTextInfoView.h"

@implementation OPTextInfoView

@synthesize OPTextInfoViewHeight,
OPTextInfoSuperView,
amountBelowParentInfoView,
textFontSize,
textFontType,
parentInfoView,
OPTextInfoViewWidth;

- (id)initOPTextViewWithSuperView:(UIView*)aSuperView withText:(NSString*)textToInsert linkedToInfoView:(OPInfoView*)anInfoView withTextFontSize:(float)aTextFontSize withFontType:(NSString*)aFontType
{
    self.scrollEnabled = NO;
    [self setOPTextInfoViewHeight:30.0];
    [self setOPTextInfoViewWidth:aSuperView.frame.size.width];
    [self setAmountBelowParentInfoView:10.0];
    [self setParentInfoView:anInfoView];
    [self setOPTextInfoSuperView:aSuperView];
    [self setTextFontSize:aTextFontSize];
    [self setTextFontType:aFontType];
    
    //find the middle of the superView
    float middleOfSuperView = aSuperView.frame.size.width/2.0;
    float xPlacementInSuperView = middleOfSuperView - OPTextInfoViewWidth/2.0;
    
    //placement below the parent InfoView
    float bottomOfParentInfoView = parentInfoView.frame.origin.y + parentInfoView.frame.size.height;
    float absoluteTextInfoViewYPlacement = amountBelowParentInfoView + bottomOfParentInfoView + self.frame.size.height;
    
    CGRect frame = CGRectMake(xPlacementInSuperView,absoluteTextInfoViewYPlacement, OPTextInfoViewWidth, OPTextInfoViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self setText:textToInsert];
    [self initTextInfoView];
    return self;
}

- (id)initOPTextSubViewWithSuperView:(UIView*)aSuperView withText:(NSString*)textToInsert linkedToTextInfoView:(OPTextInfoView*)anTextInfoView withTextFontSize:(float)aTextFontSize withFontType:(NSString*)aFontType
{
    self.scrollEnabled = NO;
    [self setOPTextInfoViewHeight:80.0];
    [self setOPTextInfoViewWidth:0.8*aSuperView.frame.size.width];
    [self setAmountBelowParentInfoView:5.0];
    [self setOPTextInfoSuperView:aSuperView];
    [self setTextFontSize:aTextFontSize];
    [self setTextFontType:aFontType];
    
    //find the middle of the superView
    float middleOfSuperView = aSuperView.frame.size.width/2.0;
    float xPlacementInSuperView = middleOfSuperView - OPTextInfoViewWidth/2.0;
    
    //placement below the parent InfoView
    float bottomOfParentInfoView = anTextInfoView.frame.origin.y + anTextInfoView.frame.size.height;
    float absoluteTextInfoViewYPlacement = amountBelowParentInfoView + bottomOfParentInfoView + self.frame.size.height;
    
    CGRect frame = CGRectMake(xPlacementInSuperView,absoluteTextInfoViewYPlacement, OPTextInfoViewWidth, OPTextInfoViewHeight);
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self setText:textToInsert];
    [self initTextInfoView];
    return self;
}

-(void) initTextInfoView
{
    self.editable = NO;
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.width/40.0;
    self.layer.masksToBounds = YES;
    [self formatTextInView];
}

-(void) formatTextInView
{
    self.textAlignment = NSTextAlignmentCenter; //@"AlNile-bold" OriyaSangamMN-bold HelveticaNeue-Thin
    [self setFont:[UIFont fontWithName:self.textFontType size:self.textFontSize]];
}

@end
