//
//  UserProfileView.m
//  OpenPost
//
//  Created by Christopher Jones on 17/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "UserProfileView.h"
#import "OPButton.h"
#import "OPTextField.h"

@implementation UserProfileView

@synthesize userProfileInfo;

- (id) initWithFrame:(CGRect)aFrame{
    
    self = [super initWithFrame:aFrame];
    if (self == nil) {
        return nil;
    }
    
    [self initialiseView];
    
    return self;
}

- (void)initialiseView {

    //check the view is visible from previous close methods
    self.backgroundColor = [UIColor whiteColor];
    
    //read dictionary information
    [self setUserProfileInfo:[self readProfileDictionaryData]];
    
    
    //create the banner along the top
    float bannerWidth = 1.0*self.frame.size.width;
    float bannerXPosition = 0.0;//0.2*0.7*self.view.frame.size.width;
    float bannerHeight = 0.1*self.frame.size.height;
    float bannerYPosition = 0.0;
    CGRect bannerFrame = CGRectMake(bannerXPosition,
                                bannerYPosition,
                                bannerWidth,
                                bannerHeight);

    OPButton* banner = [[OPButton alloc] initWithFrame:bannerFrame withTitle:@"Open Post"];
    banner.layer.cornerRadius = 0.0;
    [self addSubview:banner];
    
    //build the go back button
    float backButtonWidth = 0.2*self.frame.size.width;
    float backButtonXPosition = 0.0;
    float backButtonHeight = 0.05*self.frame.size.height;
    float backButtonYPosition = 0.035*self.frame.size.height;
    CGRect backButtonFrame = CGRectMake(backButtonXPosition, backButtonYPosition, backButtonWidth, backButtonHeight);
    OPButton* backButton = [[OPButton alloc] initWithFrame:backButtonFrame withTitle:@"Back"];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17.0]];
    [backButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];

    //create the profile picture view
    float profileViewYPos = 0.5*self.frame.size.height - 200.0;
    UIImage *profileImage = [self readProfileImageToFile];
    OPInfoView * profileView;
    @try {
        profileView= [[OPInfoView alloc] initWithYCoord:profileViewYPos withSuperView:self withAnImage:profileImage];
        profileView.contentMode = UIViewContentModeScaleAspectFill;
        profileView.layer.borderWidth = 0.0f;
        [self addSubview:profileView];
    }
    @catch (NSException *exception) {
        NSLog(@"Unable to Load Facebook Profile image due to %@ \n Loading Default Image",exception);
        @try {
            profileView= [[OPInfoView alloc] initWithYCoord:profileViewYPos withSuperView:self withAnImageNamed:@"user_icon.png"];
            profileView.layer.borderWidth = 0.0f;
            [self addSubview:profileView];
        }
        @catch (NSException *exception) {
            NSLog(@"Unable to Load any image");
        }
    }
    
    float nameFieldWidth = self.frame.size.width;
    float nameFieldYPos = profileViewYPos + profileView.frame.size.height;
    float nameFieldXPos = -2.0;
    float nameFieldHeight = 0.1*self.frame.size.height;
    
    //create the first and last name fields
    CGRect nameFieldFrame = CGRectMake(nameFieldXPos,
                                       nameFieldYPos,
                                       nameFieldWidth,
                                       nameFieldHeight);

    @try {
        NSString * userProfileName = [NSString stringWithFormat:@"%@ %@",[userProfileInfo objectForKey:@"first_name"],[userProfileInfo objectForKey:@"last_name"]];
        OPTextField* nameField = [[OPTextField alloc] initForUserProfileWithFrame:nameFieldFrame withTitle:userProfileName isSecure:YES];
        [self addSubview:nameField];
    }
    @catch (NSException *exception) {
        NSLog(@"Error, unable to add the userProfile Name information : %@",exception);
    }

}

-(UIImage*) readProfileImageToFile
{
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"profile.png"]; //Add the file name
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        return image;
    }
    @catch (NSException *exception) {
        NSLog(@"Error reading profile image: %@",exception);
        return nil;
    }
}

-(NSDictionary*) readProfileDictionaryData
{
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *dictPath = [documentsPath stringByAppendingPathComponent:@"profileDic.out"]; //Add the file name
        NSDictionary *dictFromFile = [NSDictionary dictionaryWithContentsOfFile:dictPath];
        return dictFromFile;
    }
    @catch (NSException *exception) {
        NSLog(@"Error reading profile image: %@",exception);
        return nil;
    }
}

-(void) goBackAction{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         //do nothing
    }];
}

@end
