//
//  UserProfileView.h
//  OpenPost
//
//  Created by Christopher Jones on 17/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK.h>
#import "OPInfoView.h"

@interface UserProfileView : UIView <FBLoginViewDelegate>

- (id) initWithFrame:(CGRect)aFrame;
- (void)initialiseView;

@property (weak,nonatomic) NSDictionary<FBGraphUser>* userInfo;

@end
