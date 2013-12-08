//
//  Webservices.m
//  Grand Lucayan - Guest App
//
//  Created by Chris Martinez on 12/8/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCAsynchronousTestCase.h"
#import "../../Shared/Webservices/BaseWebservice.h"
#import "../../Libraries/CoreNetworkCommunicationProject/include/CoreNetworkCommunicationLibrary/CoreNetworkCommunicationResponse.h"

@interface WebserviceTests : XCAsynchronousTestCase <BaseWebserviceDelegate>
@end

@implementation WebserviceTests {
    NSData * _data;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testBase
{
    BaseWebservice * webservice = [BaseWebservice new];
    
    XCTAssertNotNil(webservice, @"webservice is nil");
}

- (void)testDeleteGuest
{
    BaseWebservice * webservice = [BaseWebservice new];
    // /guest/:guest_id/location/:location_id
    // Deletes a location once a guest leaves the practical range.
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@/guest/:guest_id/location/:location_id", webservice.baseURL];
    webservice.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice DELETE];
    
    [self waitForBlockToComplete];
}

- (void)testGetGuests
{
    BaseWebservice * webservice = [BaseWebservice new];
    // /guests
    // retrieves all guests
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@/guests", webservice.baseURL];
    webservice.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice GET];
    
    [self waitForBlockToComplete];
}

- (void)testGetLocations
{
    BaseWebservice * webservice = [BaseWebservice new];
    // /locations
    // retrieves all locations
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@/locations", webservice.baseURL];
    webservice.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice GET];
    
    [self waitForBlockToComplete];
}

- (void)testPostGuest
{
    BaseWebservice * webservice = [BaseWebservice new];
    // /guest/:guest_id/
    // creates a new guest and registers the device
    //Body parameters: fname, lname, email, phone, device_id all required.
    //Must be JSON.
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@/guest/:guest_id/", webservice.baseURL];
    webservice.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice POST:nil];
    
    [self waitForBlockToComplete];
}

- (void)testPutGuest
{
    BaseWebservice * webservice = [BaseWebservice new];
    // /guest/:guest_id/location/:location_id/proximity/:proximity
    // Ex. /guest/abc/location/def/proximity/100
    //This service will update an existing guest location if it exists, or add it if it doesn't.  This way you can just constantly send locations without worrying about if it is a new location or not.
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@/guest/:guest_id/location/:location_id/proximity/:proximity", webservice.baseURL];
    webservice.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice PUT:nil];
    
    [self waitForBlockToComplete];
}

#pragma mark - BaseWebserviceDelegate

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
    [self endBlockWait];
    XCTAssertNotNil(response, @"serviceCallDidFinishLoading");
    XCTAssertFalse(response.status == 0, @"Status should never be 0.");
    _data = response.data;
}

- (void)serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
    [self endBlockWait];
    
    XCTFail(@"serviceCallDidFailWithError");
}

@end
