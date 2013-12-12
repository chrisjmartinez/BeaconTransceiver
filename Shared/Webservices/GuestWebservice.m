//
//  GuestWebservice.m
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "GuestWebservice.h"

@implementation GuestWebservice

- (instancetype) init {
    self = [super init];
    
    if (self) {
        // initialize the object
        NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    }
    
    return self;
}

- (void)deleteGuest:(NSString *)guestID location:(NSString *)locationID {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guest/:guest_id/location/:location_id
    // Deletes a location once a guest leaves the practical range.
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guest/%@/location/%@", self.baseURL, (long)self.port, guestID, locationID];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = GuestWebserviceTypeDelete;
    
    [self DELETE];
}

- (void)getGuests {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guests
    // retrieves all guests
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guests", self.baseURL, (long)self.port];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = GuestWebserviceTypeGet;
    
    [self GET];
    
}

- (void)getGuestsForAllLocations {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guests
    // retrieves all guests for all locations
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guest/locations/all", self.baseURL, (long)self.port];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = GuestWebserviceTypeGetAllLocations;
    
    [self GET];
}

- (void)postGuest:(NSString *)guestID guest:(Guest *)guest {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guest/:guest_id/
    // creates a new guest and registers the device
    //Body parameters: fname, lname, email, phone, device_id all required.
    //Must be JSON.
    
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guest/%@/", self.baseURL, (long)self.port, guestID];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    NSDictionary * body = @{@"fname": guest.firstName,
                            @"lname": guest.lastName,
                            @"email" :guest.eMail,
                            @"phone": guest.phoneNumber,
                            @"device_id": guest.deviceID};
    
    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
    
    self.type = GuestWebserviceTypePost;
    
    [self POST:jsonData];
}

- (void)putGuests:(NSString *)guestID location:(NSString *)locationID proximity:(NSString *)proximityID {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guest/:guest_id/location/:location_id/proximity/:proximity
    // Ex. /guest/abc/location/def/proximity/100
    //This service will update an existing guest location if it exists, or add it if it doesn't.  This way you can just constantly send locations without worrying about if it is a new location or not.
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guest/%@/location/%@/proximity/%@", self.baseURL, (long)self.port, guestID, locationID, proximityID];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = GuestWebserviceTypePut;
    
    [self PUT:nil];
}

- (void)putGuest:(NSString *)guestID location:(NSString *)locationID uuid:(NSUUID *)uuid major:(CLBeaconMajorValue)major minor:(CLBeaconMinorValue)minor proximity:(CLProximity)proximity {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    // /guest/:guest_id/location/:location_id/proximity/:proximity
    // Ex. /guest/abc/location/def/proximity/100
    //This service will update an existing guest location if it exists, or add it if it doesn't.  This way you can just constantly send locations without worrying about if it is a new location or not.
    // set the webservice URL
    NSString *urlString = [NSString stringWithFormat:@"%@:%ld/guest/%@/location/%@/proximity/%d", self.baseURL, (long)self.port, guestID, [uuid UUIDString], proximity];
    self.networkCommunication.settings.url = [NSURL URLWithString:urlString];
    
    self.type = GuestWebserviceTypePut;
    
    [self PUT:nil];
}

@end
