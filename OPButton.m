//
//  OPButton.m
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPButton.h"

@implementation OPButton

-(id)initWithFrame:(CGRect)frame withTitle:(NSString*)aTitle
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    //specifications for a UIButton
    UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
    self.backgroundColor = OPColour;
    self.layer.cornerRadius = self.frame.size.width/90.0;
    self.layer.masksToBounds = YES;
    
    //format the font for the Login Button
    [self setTitle:aTitle forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return self;
}


@end
