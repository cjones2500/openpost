//
//  ViewController.h
//  OpenPost
//
//  Created by Christopher Jones on 01/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *testLabel;



//First Info Sub View for main view controller
@property (weak, nonatomic) IBOutlet UIView *firstInfoSubView;
@property (nonatomic,assign) float originalFirstInfoViewXPosition;
@property (nonatomic,assign) BOOL isFirstInfoViewInScreen;
@property (nonatomic,assign) float firstInfoViewMoveOffAmount;

@end

