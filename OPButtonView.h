//
//  OPButtonView.h
//  OpenPost
//
//  Created by Christopher Jones on 07/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPButtonView : UIView

@property (nonatomic,assign) float OPButtonViewWidth;
@property (nonatomic,assign) float OPButtonViewHeight;

- (id)initWithYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView;

-(void) placeButtonInViewWithYPos:(CGFloat)aYPos withPercentageWidth:(float)aPercentageWidth;

@end
