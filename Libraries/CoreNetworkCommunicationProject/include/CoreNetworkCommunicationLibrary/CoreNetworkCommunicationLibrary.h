//
//  CoreNetworkCommunicationLibrary.h
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 9/26/13.
//  Copyright (c) 2013 VITAS Healthcare Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreNetworkCommunicationProtocol.h"
#import "CoreNetworkCommunicationSettings.h"

@interface CoreNetworkCommunicationLibrary : NSObject

+ (id<CoreNetworkCommunicationProtocol>)createNetworkCommunicationObject:(CoreNetworkCommunicationSettings*)settings;

@end
