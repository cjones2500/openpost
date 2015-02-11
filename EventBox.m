//
//  EventBox.m
//  OpenPost
//
//  Created by Christopher Jones on 09/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "EventBox.h"


@implementation EventBox

@synthesize roundedEventImage,
eventTitleLabel,
organiserName,
eventName,
eventCreatorImage;

-(id)initWithFrame:(CGRect)frame withEventTitle:(NSString*)aTitle withOrganiserName:(NSString*)anOrganiser withAnEventImageNamed:(NSString*)anEventImageName withAnOrganiserImageNamed:(NSString*)anOrganiserImageName
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self setOrganiserName:anOrganiser];
    [self setEventName:aTitle];
    
    UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
    self.backgroundColor = OPColour;
    self.layer.cornerRadius = self.frame.size.width/90.0;
    self.layer.masksToBounds = YES;
    
    double roundedImageBoundary = 0.75*self.frame.size.height;
    double roundedImageXCoord = 0.05*self.frame.size.width;
    double roundedImageYCoord = 0.15*self.frame.size.height;
    
    self.roundedEventImage = [[OPInfoView alloc] initWithXCoord:roundedImageXCoord
                                                            withYCoord:roundedImageYCoord
                                                             withWidth:roundedImageBoundary
                                                            withHeight:roundedImageBoundary
                                                         withSuperView:self
                                                      withAnImageNamed:anEventImageName];
    [self addSubview:roundedEventImage];
    
    //include continuous animation of the person the event was created by
    self.eventCreatorImage = [[OPInfoView alloc] initWithXCoord:roundedImageXCoord
                                                            withYCoord:roundedImageYCoord
                                                             withWidth:roundedImageBoundary
                                                            withHeight:roundedImageBoundary
                                                         withSuperView:self
                                                      withAnImageNamed:anOrganiserImageName];
    eventCreatorImage.alpha = 0.0;
    [self addSubview:eventCreatorImage];
    

    double eventLabelXCoord = 2.0*roundedImageXCoord + roundedImageBoundary;
    
    //Event label frame
    CGRect eventLabelFrame = CGRectMake(eventLabelXCoord,               //label x position
                                        0.0,                            //label y position
                                        0.6*self.frame.size.width,      //label width
                                        1.0*self.frame.size.height);    //label height
    
    //format the UILabel
    self.eventTitleLabel = [[UILabel alloc] initWithFrame:eventLabelFrame];
    [eventTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [eventTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [eventTitleLabel setText:aTitle];
    [eventTitleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:eventTitleLabel];
    
    return self;
}

-(void) initialiseFlipping{
    [NSTimer scheduledTimerWithTimeInterval:3.5
                                     target:self
                                   selector:@selector(flipImage)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) flipImage{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         if(self.eventCreatorImage.alpha < 1.0){
                             //organiser of an event is active
                             self.eventCreatorImage.alpha = 1.0;
                             [self.eventTitleLabel setText:[NSString stringWithFormat:@"From %@",self.organiserName]];
                         }
                         else{
                             //event is active
                             self.eventCreatorImage.alpha = 0.0;
                             [self.eventTitleLabel setText:self.eventName];
                         }
                         
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
}

@end
