//
//  EventBox.h
//  OpenPost
//
//  Created by Christopher Jones on 09/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

//TODO: Order each event by time and associate information of the event with the eventBox

#import <UIKit/UIKit.h>
#import "OPInfoView.h"

@interface EventBox : UIView

@property (nonatomic) OPInfoView* roundedEventImage;
@property (nonatomic) OPInfoView* eventCreatorImage;
@property (nonatomic) UILabel* eventTitleLabel;
@property (weak,nonatomic) NSString* organiserName;
@property (weak,nonatomic) NSString* eventName;


-(id)initWithFrame:(CGRect)frame withEventTitle:(NSString*)aTitle withOrganiserName:(NSString*)anOrganiser withAnEventImageNamed:(NSString*)anEventImageName withAnOrganiserImageNamed:(NSString*)anOrganiserImageName;
-(void)flipImage;
-(void)initialiseFlipping;

@end
