//
//  EventList.m
//  OpenPost
//
//  Created by Christopher Jones on 09/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

//TODO: Order each event by time
//TODO: Add a list view and a map view

#import "EventList.h"
#import "EventBox.h"
#import "OPButton.h"

@implementation EventList
NSMutableArray * arrayOfEventBoxes;

- (id) initWithFrame:(CGRect)aFrame{
    
    self = [super initWithFrame:aFrame];
    if (self == nil) {
        return nil;
    }
    [self initialiseView];
    
    return self;
}

- (void)initialiseView {
    self.backgroundColor = [UIColor whiteColor];
    
    //maximum size of the scrollview
    float maxmimumScollLength = 5.0*self.frame.size.height;
    
    //initialise the customScrollView
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.bounds.size.width, maxmimumScollLength);
    self.customScrollView.scrollHorizontal = NO;
    
    //create the banner along the top
    float bannerWidth = 1.0*self.frame.size.width;
    float bannerXPosition = 0.0;
    float bannerHeight = 0.1*self.frame.size.height;
    float bannerYPosition = 0.0;
    CGRect bannerFrame = CGRectMake(bannerXPosition,
                                    bannerYPosition,
                                    bannerWidth,
                                    bannerHeight);
    
    OPButton* banner = [[OPButton alloc] initWithFrame:bannerFrame withTitle:@"List View"];
    banner.layer.cornerRadius = 0.0;
    [self.customScrollView addSubview:banner];
    
    //build the go back button
    float backButtonWidth = 0.2*self.frame.size.width;
    float backButtonXPosition = 0.0;
    float backButtonHeight = 0.05*self.frame.size.height;
    float backButtonYPosition = 0.035*self.frame.size.height;
    CGRect backButtonFrame = CGRectMake(backButtonXPosition, backButtonYPosition, backButtonWidth, backButtonHeight);
    
    OPButton* backButton = [[OPButton alloc] initWithFrame:backButtonFrame withTitle:@"Back"];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17.0]];
    [backButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.customScrollView addSubview:backButton];
    
    //Spawn many event banner for as many spaces are there are within the view
    int numberOfEventBanners = 40;
    double startLocationOfBanners = bannerHeight;
    double heightOfEachBanner = (maxmimumScollLength-startLocationOfBanners)/(1.0*numberOfEventBanners);
    arrayOfEventBoxes = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    //Computationally build an array of banners for the given conditions
    for (int i = 0; i < numberOfEventBanners; i++){
        double yPosOfBanner = startLocationOfBanners + 1.0*heightOfEachBanner*i;
        CGRect bannerFrame = CGRectMake(0.0,                            //banner x position
                                        yPosOfBanner,                   //banner y position
                                        1.0*self.frame.size.width,      //banner width
                                        heightOfEachBanner);            //banner height
        
        EventBox* eventBox = [[EventBox alloc] initWithFrame:bannerFrame
                                              withEventTitle:@"Event"
                                           withOrganiserName:@"Organiser"
                                       withAnEventImageNamed:@"barca2.jpg"
                                   withAnOrganiserImageNamed:@"op.png"];
        eventBox.layer.cornerRadius = 0.0;
        [arrayOfEventBoxes addObject:eventBox];
    }
    
    //Place each banner in the array of banners into the subview
    for(EventBox* eventBox in arrayOfEventBoxes){
        [self.customScrollView addSubview:eventBox];
        [eventBox initialiseFlipping];
    }
    [self addSubview:self.customScrollView];
}

-(void) goBackAction{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
}

@end
