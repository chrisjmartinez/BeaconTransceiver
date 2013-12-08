//
//  Webservices.m
//  Grand Lucayan - Guest App
//
//  Created by Chris Martinez on 12/8/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCAsynchronousTestCase.h"
#import "BaseWebservice.h"
#import "GuestWebservice.h"
#import "LocationWebservice.h"
#import "CoreNetworkCommunicationResponse.h"

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
    GuestWebservice * webservice = [GuestWebservice new];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice deleteGuest:@"100" location:@"200"];
    
    [self waitForBlockToComplete];
}

- (void)testGetGuests
{
    GuestWebservice * webservice = [GuestWebservice new];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice getGuests];
    
    [self waitForBlockToComplete];
}

- (void)testGetLocations
{
    LocationWebservice * webservice = [LocationWebservice new];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice getLocations];
    
    [self waitForBlockToComplete];
}

- (void)testPostGuest
{
    GuestWebservice * webservice = [GuestWebservice new];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    Guest * guest = [Guest new];
    guest.firstName = @"joe";
    guest.lastName = @"smith";
    guest.eMail = @"joe@aol.com";
    guest.phoneNumber = @"555-555-5555";
    guest.deviceID = @"1234";
    
    [webservice postGuest:@"100" guest:guest];
    
    [self waitForBlockToComplete];
}

- (void)testPutGuest
{
    GuestWebservice * webservice = [GuestWebservice new];
    webservice.delegate = self;
    
    [self startBlockWait];
    
    [webservice putGuests:@"100" location:@"200" proximity:@"300"];
    
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
