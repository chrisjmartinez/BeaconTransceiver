//
//  BaseWebservice.h
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import <Foundation/Foundation.h>
#import "../../Libraries/CoreNetworkCommunicationProject/include/CoreNetworkCommunicationLibrary/CoreNetworkCommunicationLibrary.h"
#import "../../Libraries/CoreNetworkCommunicationProject/include/CoreNetworkCommunicationLibrary/CoreNetworkCommunicationProtocol.h"

@class BaseWebservice;

@protocol BaseWebserviceDelegate

@optional
- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response;
- (void)serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error;
@end

@interface BaseWebservice : NSObject <CoreNetworkCommunicationDelegate>

@property (weak, nonatomic) id <BaseWebserviceDelegate> delegate;
@property (strong, nonatomic) id<CoreNetworkCommunicationProtocol> networkCommunication;
@property (copy, nonatomic) NSString * baseURL;
@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) NSDictionary * dictionary;
@property (strong, nonatomic) NSArray * array;
@property (assign, nonatomic) NSInteger type;

- (instancetype) initWithSettings:(CoreNetworkCommunicationSettings *)settings;

- (void) DELETE;
- (void) GET;
- (void) POST:(NSData *)data;
- (void) PUT:(NSData *)data;

@end
