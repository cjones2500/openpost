//
//  OPButtonView.m
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPButtonView.h"
#import "OPButton.h"
#import "ViewController.h"

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
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.width/90.0;
    self.layer.masksToBounds = YES;
}

-(void) placeButtonInViewWithXPos:(float)anXPos withPercentageWidth:(float)aPercentageWidth withTitle:(NSString*)aTitle{
    @try {
        float widthOfButtonInView = self.frame.size.width*aPercentageWidth/100.0;
        
        //add generic button
        CGRect loginButtonFrame = CGRectMake(anXPos, 0.0, widthOfButtonInView,self.frame.size.height);
        OPButton* loginButton = [[OPButton alloc] initWithFrame:loginButtonFrame withTitle:aTitle];
        [self addSubview:loginButton];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error adding UIButton to view %@",exception);
    }
}

-(void) addTargetToButtonWithTitle:(NSString*)aTitle withFunction:(SEL)anAction fromObject:(id)theObject
{
    for (OPButton* aOPButton in self.subviews){
        if([aOPButton isKindOfClass:[OPButton class]]){
            [aOPButton addTarget:theObject action:@selector(onClickLogin) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void) placeHorizontalLineInViewWithXCoord:(CGFloat)xCoord
{
    CGRect lineFrame = CGRectMake(xCoord, 0.0, 1.0,self.frame.size.height);
    UIView *lineView = [[UIView alloc] initWithFrame:lineFrame];
    lineView.backgroundColor = [UIColor blackColor];
    [self addSubview:lineView];
}

@end
