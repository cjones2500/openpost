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
@property (nonatomic,assign) float textFontSize;
@property (weak,nonatomic) NSString* textFontType;

@property (weak,nonatomic) UIView* OPTextInfoSuperView;
@property (weak,nonatomic) OPInfoView* parentInfoView;

- (id)initOPTextViewWithSuperView:(UIView*)aSuperView withText:(NSString*)textToInsert linkedToInfoView:(OPInfoView*)anInfoView withTextFontSize:(float)aTextFontSize withFontType:(NSString*)aFontType;

- (id)initOPTextSubViewWithSuperView:(UIView*)aSuperView withText:(NSString*)textToInsert linkedToTextInfoView:(OPTextInfoView*)anInfoView withTextFontSize:(float)aTextFontSize withFontType:(NSString*)aFontType;

- (void)initTextInfoView;
- (void)formatTextInView;

@end
