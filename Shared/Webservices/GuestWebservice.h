//
//  GuestWebservice.h
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "BaseWebservice.h"

typedef enum {
    GuestWebserviceTypeDelete = 1,
    GuestWebserviceTypeGet = 2,
    GuestWebserviceTypePost = 3,
    GuestWebserviceTypePut = 4,
} GuestWebserviceType;

@interface Guest : NSObject
@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (strong, nonatomic) NSString * eMail;
@property (strong, nonatomic) NSString * phoneNumber;
@property (strong, nonatomic) NSString * deviceID;
@end

@interface GuestWebservice : BaseWebservice

- (void)deleteGuest:(NSString *)guestID location:(NSString *)locationID;
- (void)getGuests;
- (void)postGuest:(NSString *)guestID guest:(Guest *)guest;
- (void)putGuests:(NSString *)guestID location:(NSString *)locationID proximity:(NSString *)proximityID;

@end
