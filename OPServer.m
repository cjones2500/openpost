//
//  OPServer.m
//  OpenPost
//
//  Created by Christopher Jones on 03/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import "OPServer.h"

@implementation OPServer

void checkServerAndProceed(void(^checkFunction)(void), void(^proceedFunction)(void)) {
    dispatch_queue_t downloadQueue = dispatch_queue_create("check_and_process_queue",NULL);
    dispatch_sync(downloadQueue, ^{
        checkFunction();
        dispatch_async(dispatch_get_main_queue(), ^{
            proceedFunction();
        });
    });
}

@end
