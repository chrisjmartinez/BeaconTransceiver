//
//  GuestWebservice.h
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "BaseWebservice.h"
#include "Guest.h"

typedef enum {
    GuestWebserviceTypeDelete = 1,
    GuestWebserviceTypeGet = 2,
    GuestWebserviceTypePost = 3,
    GuestWebserviceTypePut = 4,
} GuestWebserviceType;

@interface GuestWebservice : BaseWebservice

- (void)deleteGuest:(NSString *)guestID location:(NSString *)locationID;
- (void)getGuests;
- (void)postGuest:(NSString *)guestID guest:(Guest *)guest;
- (void)putGuests:(NSString *)guestID location:(NSString *)locationID proximity:(NSString *)proximityID;

@end
