//
//  GuestWebservice.h
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "BaseWebservice.h"
#import "Guest.h"

typedef enum {
    GuestWebserviceTypeDelete = 1,
    GuestWebserviceTypeGet = 2,
    GuestWebserviceTypeGetAllLocations = 3,
    GuestWebserviceTypePost = 4,
    GuestWebserviceTypePut = 5,
} GuestWebserviceType;

@interface GuestWebservice : BaseWebservice

- (void)deleteGuest:(NSString *)guestID location:(NSString *)locationID;
- (void)getGuests;
- (void)getGuestsForAllLocations;
- (void)postGuest:(NSString *)guestID guest:(Guest *)guest;
- (void)putGuests:(NSString *)guestID location:(NSString *)locationID proximity:(NSString *)proximityID;
- (void)putGuest:(NSString *)guestID uuid:(NSUUID *)uuid major:(CLBeaconMajorValue)major minor:(CLBeaconMinorValue)minor proximity:(CLProximity)proximity;

@end
