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
#import "EventList.h"

#define safeSet(d,k,v) if (v) d[k] = v;

static NSString* const kBaseURL = @"https://openpost.herokuapp.com/";
//static NSString* const kBaseURL = @"htp://localhost:5000/";

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
BOOL isUserAlreadyInDatabase;
NSDictionary<FBGraphUser> *userInfo;
NSDictionary *userInfoForOPDb;
UIImage *fbProfileImg;
EventList *eventList;



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
             
             //if there is no error loading from Facebook
             if (!error) {
                 userInfo = user;
                 [profileView setUserProfileInfo:user];
                 
                 checkServerAndProceed(^{
                     NSString *facebookId = userInfo.objectID;
                     NSString *imageUrlString = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                     NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
                     NSData *data = [NSData dataWithContentsOfURL:imageUrl];
                     fbProfileImg = [UIImage imageWithData:data];
                 
                 },^{
                     // Update the UI
                     [self.userButton setImage:fbProfileImg];
                     
                     //save the profile Image to file such that in can be downloaded later
                     [self writeProfileImageToFile:fbProfileImg];
                     
                     //save profile data to the phone
                     NSDictionary * profileDataToWriteAndSave = [userInfo copy];
                     [self writeProfileDataToFile:profileDataToWriteAndSave];
                 });
                 
                 checkServerAndProceed(^{[self isUserPresentInOpDb]; },
                                       ^{[self sendFbDataWithString:userInfoForOPDb]; });
             }
         }];
        }); //end of the sync on custom queue
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


//Move into the profile view
-(void) openProfile{
    eventList = [[EventList alloc] initWithFrame:self.view.frame];
    [self transitionToGenericView:eventList];
    
    /*profileView = [[UserProfileView alloc] initWithFrame:self.view.frame];
    [self transitionToGenericView:profileView];*/
}

- (void)transitionToGenericView:(UIView*)aGenericView{
    aGenericView.alpha = 0.0; //make the view transparent
    [self.view addSubview:aGenericView];
    [self.view bringSubviewToFront:aGenericView];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         aGenericView.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //do nothing
                     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isUserPresentInOpDb
{
    __block NSArray* responseArray;
    
    //request the information
    NSString* queryString = [NSString stringWithFormat:@"?id=%@",[userInfo objectForKey:@"id"]];
    NSString* urlStr = [[kBaseURL stringByAppendingPathComponent:@"userData"] stringByAppendingString:queryString];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSLog(@" url to use : %@",url);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"received %d items", responseArray.count);
            
            if(responseArray.count > 0){
                isUserAlreadyInDatabase = YES;
            }
            else{
                isUserAlreadyInDatabase = NO;
            }
        }
        else{
            NSLog(@"Error checking db %@",error);
        }
    }];
    [dataTask resume];
    
}

//push data to from the database
- (void)sendFbDataWithString:(NSDictionary*)aJsonDic
{
    NSString* urlForNewData = [kBaseURL stringByAppendingPathComponent:@"userData"];
    
    //NSLog(@"isUser db %d",isUserAlreadyInDatabase);
    NSURL* url = isUserAlreadyInDatabase ? [NSURL URLWithString:[urlForNewData stringByAppendingPathComponent:[aJsonDic objectForKey:@"_id"]]] : [NSURL URLWithString:urlForNewData];
    
    //NSLog(@"url %@",url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isUserAlreadyInDatabase ? @"PUT" : @"POST";
    //NSLog(@"request to move %@",request.HTTPMethod);
    NSData *data;
    @try {
        data =[NSJSONSerialization dataWithJSONObject:userInfo options:0 error:NULL];
        request.HTTPBody = data;
    }
    @catch (NSException *exception) {
        NSLog(@"Error : %@",exception);
        return; //early exit
    }
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            //NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
        }
    }];
    
    [dataTask resume]; //8
}


- (void)close {
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
