//
//  CoreNetworkCommunicationProtocol.h
//  
//
//  Created by Chris Martinez on 9/26/13.
//
//

#import <Foundation/Foundation.h>

@class CoreNetworkCommunicationSettings;
@class CoreNetworkCommunicationResponse;

#pragma mark - Protocol delegate

@protocol CoreNetworkCommunicationDelegate

@optional
- (void)networkCallDidFinishLoading:(CoreNetworkCommunicationResponse *)response;
- (void)networkCallDidFailWithError:(NSError *)error;
- (void)networkCallDidReceiveData:(NSData *)data;

@end

@protocol CoreNetworkCommunicationProtocol

#pragma mark - Protocol properties
@required

@property (strong, nonatomic) CoreNetworkCommunicationSettings * settings;
@property (assign, nonatomic) BOOL isActive;

@optional
@property (weak, nonatomic) id <CoreNetworkCommunicationDelegate> delegate;

#pragma mark - Prototol methods

@required

- (void)DELETE;
- (void)GET;
- (void)POST:(NSData *)data;
- (void)PUT:(NSData *)data;

@optional
- (void)toggleNetworkActivity:(BOOL)visible;

@end
