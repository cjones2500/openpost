//
//  OPTextField.h
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPTextField : UITextField

-(id)initWithFrame:(CGRect)frame withTitle:(NSString*)aTitle isSecure:(BOOL)isSecure;
-(id)initForUserProfileWithFrame:(CGRect)frame withTitle:(NSString*)aTitle isSecure:(BOOL)isSecure;

@end
