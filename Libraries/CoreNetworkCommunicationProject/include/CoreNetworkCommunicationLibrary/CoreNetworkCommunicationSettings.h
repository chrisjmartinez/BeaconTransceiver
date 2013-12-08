//
//  CoreNetworkCommunicationSettings.h
//  
//
//  Created by Chris Martinez on 9/26/13.
//
//

#import <Foundation/Foundation.h>

@interface CoreNetworkCommunicationSettings : NSObject

@property (assign) BOOL showNetworkActivity;
@property (assign) NSDictionary * headers;
@property (retain) NSURL * url;
@property (assign) NSInteger timeout; // in seconds
@property (assign) BOOL enableCompression;
@property (assign) NSInteger retries;

@end
