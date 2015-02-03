//
//  OPServer.h
//  OpenPost
//
//  Created by Christopher Jones on 03/02/2015.
//  Copyright (c) 2015 Christopher Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPServer : NSObject

/*This function has been created as a C-function http://code.tutsplus.com/tutorials/understanding-objective-c-blocks--mobile-14319 */

void checkServerAndProceed(void (^)(void),void (^)(void));

@end
