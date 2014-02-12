//
//  LocationManagerTests.m
//  VitasSuite
//
//  Created by Chris Martinez on 12/9/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCAsynchronousTestCase.h"
#import "LocationManager.h"

@interface LocationManagerTests : XCAsynchronousTestCase <LocationManagerDelegate>

@end

@implementation LocationManagerTests {
    LocationManager * locationManager;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    locationManager = [LocationManager sharedLocationManager];
    locationManager.delegate = self;
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    locationManager = nil;
    
    [super tearDown];
}

- (void)testInitialization
{
    XCTAssertNotNil(locationManager, @"LocationManager initialization failed");
}

- (void)testLocation
{
    [self startBlockWait];
    
    [locationManager refresh];
    
    [self waitForBlockToComplete];
}

- (void)testAddress
{
    [self startBlockWait];
    
    [locationManager refresh];
    
    [self waitForBlockToComplete];
   
    LocationAddress * address = locationManager.address;
    
    // Address should be 6167 Royal Birkdale Dr, Lake Worth FL 33463
    if (address) {
        XCTAssertNotNil(address, @"testAddress address is nil");
        XCTAssertTrue([address.street isEqualToString:@"6167 Royal Birkdale Dr"], @"street is wrong");
        XCTAssertTrue([address.city isEqualToString:@"Lake Worth"], @"city is wrong");
        XCTAssertTrue([address.state isEqualToString:@"FL"], @"state is wrong");
        XCTAssertTrue([address.zipCode isEqualToString:@"33463"], @"zipCode  is wrong");
    } else {
        // no address was returned, make sure the location is not nil
        XCTAssertNotNil(locationManager.location, @"didUpdateLocation location is nil");
    }
}
#pragma mark - LocationManagerDelegate

- (void) didFailLocationUpdate:(NSError *)error {
    [self endBlockWait];
    XCTAssertTrue(NO, @"didFailLocationUpdate");
}

- (void) didUpdateLocationWithAddress:(CLLocation *)location address:(LocationAddress *)address {
    [self endBlockWait];
    XCTAssertNotNil(location, @"didUpdateLocationWithAddress location is nil");
    XCTAssertNotNil(address, @"didUpdateLocationWithAddress address is nil");
}

@end
