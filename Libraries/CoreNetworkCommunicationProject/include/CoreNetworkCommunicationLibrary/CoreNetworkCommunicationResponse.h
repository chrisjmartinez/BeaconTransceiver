//
//  CoreNetworkCommunicationResponse.h
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 9/26/13.
//  Copyright (c) 2013 VITAS Healthcare Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreNetworkCommunicationResponse : NSObject

@property (assign) NSData *data;
@property (assign) int status;
@property (assign) NSString * message;

@end
