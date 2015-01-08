//
//  OPLogo.m
//  OpenPost
//
//  Created by Christopher Jones on 08/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPLogo.h"

@implementation OPLogo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //establish graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] setFill];
    
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), CGRectGetWidth(rect)/2, 0, 2*M_PI, YES);
    
    CGContextFillPath(context);
    [self drawSubtractedText:@"OP" inRect:rect inContext:context];
    
    
    
}

/*- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //amount to move the shadow offset in x and y direction
    CGSize  myShadowOffset = CGSizeMake (-20.0,  20.0);
    
    CGContextSaveGState(context);
    //CGContextSetShadow (context, myShadowOffset, 10.0);
    
    CGContextSetLineWidth(context, 4.0);
    
    //create a colour space with OP Colour
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {204.0/255.0, 229.0/255.0, 1.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    CGRect rectangle = CGRectMake(60,170,200,200);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
    //CGContextRestoreGState(context);
    
    //create the line
    
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, color);
    //set starting point
    CGContextMoveToPoint(context, 135, 220);
    
    //end point of the line
    CGContextAddLineToPoint(context, 135, 320);
    
    CGContextMoveToPoint(context, 135, 270);
    
    CGContextAddArc(context, 135,220,35, -M_PI/2.0, M_PI/2.0, 0);

    //CGContextAddArcToPoint(context,165,240,135,220,30.0);
    
    //draw the line itself
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}*/

/*- (void)drawRect:(CGRect)rect {
    // Make sure the UIView's background is set to clear either in code or in a storyboard/nib
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] setFill];
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), CGRectGetWidth(rect)/2, 0, 2*M_PI, YES);
    CGContextFillPath(context);
    
    // Manual offset may need to be adjusted depending on the length of the text
    [self drawSubtractedText:@"O P" inRect:rect inContext:context];
}*/

- (void)drawSubtractedText:(NSString *)text inRect:(CGRect)rect inContext:(CGContextRef)context {
    
    // Save context state to not affect other drawing operations
    CGContextSaveGState(context);
    
    // Magic blend mode - include this to see through to the bottom
    //CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    
    UIColor *OPColour = [[UIColor alloc] initWithRed:204.0/255.0 green:229.0/255.0 blue:1.0 alpha:1.0];
    
    // This seemingly random value adjusts the text
    // vertically so that it is centered in the circle.
    CGFloat Y_OFFSET = -2 * (float)[text length] + 5;
    
    // Context translation for label
    CGFloat LABEL_SIDE = CGRectGetWidth(rect);
    CGContextTranslateCTM(context, 0, CGRectGetHeight(rect)/2-LABEL_SIDE/2+Y_OFFSET);
    
    // Label to center and adjust font automatically
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABEL_SIDE, LABEL_SIDE)];
    label.font = [UIFont boldSystemFontOfSize:120];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = text;
    label.textColor = OPColour;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor]; //sets the colour of the background
    [label.layer drawInContext:context];
    
    // Restore the state of other drawing operations
    CGContextRestoreGState(context);
    
    //[self setBackgroundColor:[UIColor whiteColor]];
    
}

//give the width of the line
/*CGContextSetLineWidth(context, 2.0);

//create a colour space
CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//use OP Colour
CGFloat components[] = {204.0/255.0, 229.0/255.0, 1.0, 1.0};
CGColorRef color = CGColorCreate(colorspace, components);
CGContextSetStrokeColorWithColor(context, color);

//set starting point
CGContextMoveToPoint(context, 30, 30);

//end point of the line
CGContextAddLineToPoint(context, 300, 400);

//draw the line itself
CGContextStrokePath(context);
CGColorSpaceRelease(colorspace);
CGColorRelease(color);*/



@end
