//
//  OPMapVC.m
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPMapVC.h"
#import "OPTransition.h"
#import "OPButton.h"
#import "OPInfoView.h"
#import "UserProfileView.h"
#import <QuartzCore/QuartzCore.h>


#define safeSet(d,k,v) if (v) d[k] = v;

static NSString* const kBaseURL = @"http://localhost:5000/";
static NSString* const kLocations = @"items";
//static NSString* const kFiles = @"files";

/*NOTE:
    THIS SERVER currently is hosted locally and requires and active mongodb instance.
    current service : mongod --dbpath /Users/cjones/mongodb/data/db
 
    This also requires the server to be active on a port 5000
    $cd .../node_project..
    $foreman start

    This also requires for some data to exist on the mongoDb server and this information is
    subsequently installed
 
*/

/*TODO: 
    Once the main version of this is working a big clean up of naming convention and titles
    is required. This also needs to be made secure. Type-safe? This needs to be made safe,
    such that people cannot force code to read the database
*/
 
@interface OPMapVC () <UIViewControllerTransitioningDelegate,FBLoginViewDelegate>

@end

@implementation OPMapVC

UserProfileView * profileView;
BOOL isFacebookSessionActive;
NSDictionary<FBGraphUser> *userInfo;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //add the MapView to the controller
    MKMapView * theMapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    theMapView.delegate = self;
    [self.view addSubview:theMapView];
    
    
    //create the banner along the top
    float bannerWidth = 1.0*self.view.frame.size.width;
    float bannerXPosition = 0.0;//0.2*0.7*self.view.frame.size.width;
    float bannerHeight = 0.1*self.view.frame.size.height;
    float bannerYPosition = 0.0;
    CGRect bannerFrame = CGRectMake(bannerXPosition,
                                    bannerYPosition,
                                    bannerWidth,
                                    bannerHeight);
    
    OPButton* banner = [[OPButton alloc] initWithFrame:bannerFrame withTitle:@"Profile"];
    banner.layer.cornerRadius = 0.0;
    [self.view addSubview:banner];
    
    //create the user button
    float userButtonLength = 0.09*self.view.frame.size.width;
    float userButtonXPosition = 0.05*self.view.frame.size.width;
    float userButtonYPosition = 0.035*self.view.frame.size.height;
    CGRect userButtonFrame = CGRectMake(userButtonXPosition,
                                    userButtonYPosition,
                                    userButtonLength,
                                    userButtonLength);
    
    self.userButton = [[OPInfoView alloc] initWithFrame:userButtonFrame];
    [self.userButton initOPInfoViewWithImage:@"user_icon.png"];
    [self.userButton setUserInteractionEnabled:YES];
    //add user button response to profile view
    UITapGestureRecognizer * tapToSeeProfile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openProfile)];
    [self.userButton addGestureRecognizer:tapToSeeProfile];
    [self.view addSubview:self.userButton];
    
    //build the logout button
    float logOutButtonWidth = 0.2*self.view.frame.size.width;
    float logOutButtonXPosition = self.view.frame.size.width - logOutButtonWidth;
    float logOutButtonHeight = 0.05*self.view.frame.size.height;
    float logOutButtonYPosition = 0.035*self.view.frame.size.height;//0.7*self.view.frame.size.height - submitButtonHeight;
    CGRect logOutButtonFrame = CGRectMake(logOutButtonXPosition, logOutButtonYPosition, logOutButtonWidth, logOutButtonHeight);
    OPButton* logOutButton = [[OPButton alloc] initWithFrame:logOutButtonFrame withTitle:@"Log Out"];
    [logOutButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17.0]];
    [logOutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutButton];
    
}

-(void) test{
    NSString *facebookId = userInfo.objectID;
    NSLog(@"In dispatch facebookId : %@",facebookId);
    NSString *imageUrlString = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *fbProfileImg = [UIImage imageWithData:data];
    NSLog(@"UIImage outside %@",fbProfileImg);
    [self.userButton setImage:fbProfileImg];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadFacebookInformation];
}

-(void)loadFacebookInformation
{
    if (FBSession.activeSession.isOpen) {
        
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_sync(myQueue, ^{
        
        NSLog(@"started in sync custom queue");
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 
                 //Load the user information from Facebook
                 userInfo = user;
                 [profileView setUserProfileInfo:user];
                 
                 NSLog(@"Loaded information for user.id %@",user.objectID);
                 dispatch_async(myQueue, ^{
                     NSString *facebookId = userInfo.objectID;
                     NSLog(@"In dispatch facebookId : %@",facebookId);
                     NSString *imageUrlString = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                     NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
                     NSData *data = [NSData dataWithContentsOfURL:imageUrl];
                     UIImage *fbProfileImg = [UIImage imageWithData:data];
                     NSLog(@"UIImage outside %@",fbProfileImg);
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // Update the UI
                         [self.userButton setImage:fbProfileImg];
                         [self writeProfileImageToFile:fbProfileImg];
                         NSDictionary * profileDataToWrite = [userInfo copy];
                         [self writeProfileDataToFile:profileDataToWrite];
                     });
                 });
                 
             }
             else{
                 NSLog(@"Error downloading Facebook information: %@",error);
             }
         }];
        
            NSLog(@"finished in sync custom queue");
            
        });
    
    }
}

-(void) writeProfileImageToFile:(UIImage*)anImage
{
    NSData *pngData = UIImagePNGRepresentation(anImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"profile.png"]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
}

-(void) writeProfileDataToFile:(NSDictionary*)aDictionary
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"profileDic.out"];
    [aDictionary writeToFile:dictPath atomically:YES]; //write the dictionary to file
}


-(void) openProfile{
    NSLog(@"in here");
    //add the profile View
    profileView = [[UserProfileView alloc] initWithFrame:self.view.frame];
    profileView.alpha = 0.0; //make the view transparent
    [self.view addSubview:profileView];
    [self.view bringSubviewToFront:profileView];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         profileView.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //do nothing
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//fetch the data from the database
- (void)import
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            NSLog(@"responseArray: %@",responseArray[1]);
        }
    }];
    
    [dataTask resume]; //8
}

//push data to from the database
- (void)sendDataWithString:(NSString*)aStringToSend
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /*NSData* data = [NSJSONSerialization dataWithJSONObject:[location toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;*/
    
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    safeSet(jsonable, @"title", aStringToSend);
    NSData * data =[NSJSONSerialization dataWithJSONObject:jsonable options:0 error:NULL];
    request.HTTPBody = data;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            NSLog(@"responseArray: %@",responseArray);
        }
    }];
    
    [dataTask resume]; //8
}


- (void)close {
    //perform on closing
    [self import];
    //[self sendDataWithString:@"testing"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    @try {
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        viewController.transitioningDelegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Error thrown attempting to initialise second view: %@\n",exception);
    }
}

-(void) checkFacebookStatus
{
    if (FBSession.activeSession.isOpen)
    {
        isFacebookSessionActive = YES;
        NSLog(@"OPMapVC::Session is active");
    } else {
        isFacebookSessionActive = NO;
        NSLog(@"OPMapVC::Session is not active");
    }
}

//logs out of OpenPost
-(void) logout{
    if (FBSession.activeSession.isOpen) {
        [FBSession.activeSession close];
        [FBSession.activeSession  closeAndClearTokenInformation];
        FBSession.activeSession=nil;
    }
    //TODO: Close the session if it is an OP session as well
    [self close];
    
}

#pragma mark - Transition Delegate Required Method
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OPTransition alloc] initWithType:NO];
}

@end
