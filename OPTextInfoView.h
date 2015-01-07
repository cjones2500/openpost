//
//  OPTextInfoView.h
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPInfoView.h"

@interface OPTextInfoView : UITextView

@property (nonatomic,assign) float OPTextInfoViewWidth;
@property (nonatomic,assign) float OPTextInfoViewHeight;
@property (nonatomic,assign) float amountBelowParentInfoView;
@property (weak,nonatomic) UIView* OPTextInfoSuperView;
@property (weak,nonatomic) OPInfoView* parentInfoView;

- (id)initWithSuperView:(UIView*)aSuperView withText:(NSString*)textToInsert linkedToInfoView:(OPInfoView*)anInfoView;
- (void)initTextInfoView;
-(void) formatTextInView;

@end
