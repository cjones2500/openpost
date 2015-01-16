//
//  Locations.m
//  OpenPost
//
//  Created by Christopher Jones on 16/01/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "Locations.h"
#import "Location.h"

static NSString* const kBaseURL = @"http://localhost:5000/";
static NSString* const kLocations = @"locations";
static NSString* const kFiles = @"files";


@interface Locations ()
@property (nonatomic, strong) NSMutableArray* objects;
@end

@implementation Locations

- (id)init
{
    self = [super init];
    if (self) {
        _objects = [NSMutableArray array];
    }
    return self;
}

- (NSArray*) filteredLocations
{
    return [self objects];
}

- (void) addLocation:(Location*)location
{
    [self.objects addObject:location];
}

- (void)loadImage:(Location*)location
{
}

- (void)parseAndAddLocations:(NSArray*)locations toArray:(NSMutableArray*)destinationArray
{
    for (NSDictionary* item in locations) {
        Location* location = [[Location alloc] initWithDictionary:item]; //2
        [destinationArray addObject:location];
    }
    
    if (self.delegate) {
        [self.delegate modelUpdated]; //3
    }
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
            [self parseAndAddLocations:responseArray toArray:self.objects]; //7
        }
    }];
    
    [dataTask resume]; //8
}

- (void) runQuery:(NSString *)queryString
{
    
}

- (void) queryRegion:(MKCoordinateRegion)region
{
    
}


- (void) persist:(Location*)location
{
    if (!location || location.name == nil || location.name.length == 0) {
        return; //input safety check
    }
    
    NSString* locations = [kBaseURL stringByAppendingPathComponent:kLocations];
    
    BOOL isExistingLocation = location._id != nil;
    NSURL* url = isExistingLocation ? [NSURL URLWithString:[locations stringByAppendingPathComponent:location._id]] :
    [NSURL URLWithString:locations]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isExistingLocation ? @"PUT" : @"POST"; //2
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:[location toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            [self parseAndAddLocations:responseArray toArray:self.objects];
        }
    }];
    [dataTask resume];
}
@end