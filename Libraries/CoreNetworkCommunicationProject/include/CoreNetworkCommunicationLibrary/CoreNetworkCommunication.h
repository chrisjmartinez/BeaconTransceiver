//
//  CoreNetworkCommunication.h
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 9/26/13.
//  Copyright (c) 2013 VITAS Healthcare Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreNetworkCommunicationProtocol.h"

@interface CoreNetworkCommunication : NSObject <CoreNetworkCommunicationProtocol>

@property (strong, nonatomic) CoreNetworkCommunicationSettings * settings;
@property (assign, nonatomic) BOOL isActive;
@property (weak, nonatomic) id <CoreNetworkCommunicationDelegate> delegate;

@end
