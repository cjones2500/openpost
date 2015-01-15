//
//  OPMapVC.m
//  OpenPost
//
//  Created by Christopher Jones on 12/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPMapVC.h"
#import "OPTransition.h"

static NSString* const kBaseURL = @"http://localhost:5000/";
static NSString* const kLocations = @"items";
//static NSString* const kFiles = @"files";

@interface OPMapVC () <UIViewControllerTransitioningDelegate>

@end

@implementation OPMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tapToClose];
    
    [self import];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
