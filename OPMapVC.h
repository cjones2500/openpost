//
//  OPMapVC.h
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <FacebookSDK.h> 
#import "OPInfoView.h"

@interface OPMapVC : UIViewController <MKMapViewDelegate,FBLoginViewDelegate>

@property (nonatomic, retain) OPInfoView * userButton;

@end
