//
//  OPInfoView.h
//  OpenPost
//
//  Created by Christopher Jones on 04/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPInfoView : UIImageView

@property (nonatomic,assign) float OPInfoViewWidth;
@property (nonatomic,assign) float OPInfoViewHeight;
@property (weak,nonatomic) UIPanGestureRecognizer* OPInfoViewGesture;
@property (weak,nonatomic) UIView* OPSuperView;

- (id)initWithYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage;
- (id)initWithXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage;
- (id)initWithXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withWidth:(float)aWidth withHeight:(float)aHeight withSuperView:(UIView*)aSuperView withAnImageNamed:(NSString*)anImage;

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer;
- (void) initOPInfoViewWithImage:(NSString*)anImage;

@end
