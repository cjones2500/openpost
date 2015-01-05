//
//  OPTransition.h
//  OpenPost
//
//  Created by Christopher Jones on 01/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OPTransition : NSObject <UIViewControllerAnimatedTransitioning>{
    BOOL isPresentTransition;
    float alphaValue;
}

@property (nonatomic,assign) BOOL isPresentTransition;
@property (nonatomic,assign) float alphaValue;

-(id)initWithType:(BOOL)aType;
-(id)init;

@end
