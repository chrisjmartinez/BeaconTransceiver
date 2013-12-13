//
//  LocationWebservice.m
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "LocationWebservice.h"

@implementation LocationWebservice

- (instancetype) init {
    self = [super init];
    
    if (self) {
        // initialize the object
        NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    }
    
    return self;
}

- (void)getLocations {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /locations
    // retrieves all locations
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%d/locations", self.baseURL, self.port];
    
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = LocationWebServiceGetLocations;
    
    [self GET];
}

- (void)getGuestsForLocation:(NSString *)locationID {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /location/locationID/guests
    // retrieves all guests at a location
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%d/location/%@/guests", self.baseURL, self.port, locationID];
    
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = LocationWebServiceGetGuestsForLocation;
    
    [self GET];
}


@end
