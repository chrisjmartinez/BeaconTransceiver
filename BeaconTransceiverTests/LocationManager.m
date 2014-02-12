//
//  LocationManager.m
//  Connect
//
//  Created by Chris Martinez on 11/13/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationAddress
@end

@interface LocationManager() <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager * locMan;
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation LocationManager

SINGLETON_GCD(LocationManager)

- (instancetype) init {
    self = [super init];
    
    if (self) {
        if (!self.geocoder) {
            // Create a geocoder and save it for later.
            self.geocoder = [[CLGeocoder alloc] init];
        }
    
        [self refresh];
    }
    
	return self;
}

- (void) refresh {
    // make sure location services are available
    self.isLocationAvailable = [CLLocationManager locationServicesEnabled];
    
    if (![CLLocationManager locationServicesEnabled])
        return;
    
    // stop a previous look up
    if (nil != self.locMan) {
        [self.locMan stopUpdatingLocation];
        self.locMan = nil;
    }
        
    self.locMan = [[CLLocationManager alloc] init];
    self.locMan.delegate = self;
    self.locMan.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locMan.distanceFilter = kCLDistanceFilterNone;  // 1 mile = 1609 meters
    
    [self.locMan startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // turn off the location manager updates
        [self.locMan stopUpdatingLocation];
        self.locMan = nil;
    }

    error = [NSError errorWithDomain:NSArgumentDomain code:1 userInfo:@{@"message": @"No location could be found."}];

    [self.delegate didFailLocationUpdate:error];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    DLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    DLog(@"Lat/Lng: %f/%f)", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    DLog(@"Accuracy: %f", newLocation.horizontalAccuracy);
    DLog(@"Minimum Accuracy: %f", kCLLocationAccuracyHundredMeters);
    
    self.location = newLocation;
    [self.locMan stopUpdatingLocation];
    self.locMan = nil;
    
    // Lookup the information for the current location of the user.
    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if ((placemarks != nil) && (placemarks.count > 0)) {
            // If the placemark is not nil then we have at least one placemark. Typically there will only be one.
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            self.address = [LocationAddress new];
            self.address.street = [placemark.addressDictionary valueForKey:@"Street"];
            self.address.city = [placemark.addressDictionary valueForKey:@"City"];
            self.address.state = [placemark.addressDictionary valueForKey:@"State"];
            self.address.zipCode = [placemark.addressDictionary valueForKey:@"ZIP"];

            if (self.delegate) {
                if (newLocation.horizontalAccuracy < 0.0 || newLocation.horizontalAccuracy > kCLLocationAccuracyHundredMeters) {
                     NSError * error = [NSError errorWithDomain:NSArgumentDomain code:1 userInfo:@{@"message": @"No Address could be found for your location."}];
                    [self.delegate didFailLocationUpdate:error];
                } else {
                    [self.delegate didUpdateLocationWithAddress:self.location address:self.address];
                }
            }
        }
        else {
            // Handle the nil case if necessary.
            if (self.delegate) {
                NSError * error = [NSError errorWithDomain:NSArgumentDomain code:1 userInfo:@{@"message": @"No Address could be found for your location."}];
                [self.delegate didFailLocationUpdate:error];
            }
        }
    }];    
}

@end
