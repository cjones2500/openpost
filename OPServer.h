//
//  OPServer.h
//  OpenPost
//
//  Created by Christopher Jones on 03/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPServer : NSObject

void checkServerAndProceed(void (^)(void),void (^)(void));

@end
