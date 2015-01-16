//
//  OPMapVC.m
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPMapVC.h"
#import "OPTransition.h"
#import "Location.h"

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
 
@interface OPMapVC () <UIViewControllerTransitioningDelegate>

@end

@implementation OPMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tapToClose];
    
    [self import];
    [self sendDataWithString:@"testing"];
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

#pragma mark - Transition Delegate Required Method
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OPTransition alloc] initWithType:NO];
}

@end
