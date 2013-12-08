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
    NSString *urlString = [NSString stringWithFormat:@"%@/locations", self.baseURL];
    
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    [self GET];
}


@end
