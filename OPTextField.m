//
//  OPTextField.m
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPTextField.h"

@implementation OPTextField

-(id)initWithFrame:(CGRect)frame withTitle:(NSString*)aTitle isSecure:(BOOL)isSecure
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    //specifications for a UITextField
    UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
    self.backgroundColor = OPColour;
    self.layer.cornerRadius = self.frame.size.width/90.0;
    self.layer.masksToBounds = YES;
    UILabel *textAtBeginning = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0.35*self.frame.size.width, self.frame.size.height)];
    [textAtBeginning setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17.0]];
    [textAtBeginning setText:[NSString stringWithFormat:@"  %@",aTitle]];
    [textAtBeginning setTextColor:[UIColor blackColor]];
    [textAtBeginning setTextAlignment:NSTextAlignmentCenter];
    self.leftView = textAtBeginning;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self setSecureTextEntry:isSecure];
    
    [self setTextColor:[UIColor lightGrayColor]];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]];
    self.textAlignment = NSTextAlignmentLeft;

    return self;
}

@end
