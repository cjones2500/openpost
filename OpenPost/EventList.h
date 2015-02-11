//
//  EventList.h
//  OpenPost
//
//  Created by Christopher Jones on 09/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollView.h"

@interface EventList : UIView

@property (nonatomic) CustomScrollView *customScrollView;

- (id) initWithFrame:(CGRect)aFrame;
- (void)initialiseView;

@end
