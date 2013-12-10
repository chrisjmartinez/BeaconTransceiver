//
//  Guest.h
//  
//
//  Created by Chris Martinez on 12/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Guest : NSObject

@property (strong, nonatomic) NSString * ID;
@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (strong, nonatomic) NSString * eMail;
@property (strong, nonatomic) NSString * phoneNumber;
@property (strong, nonatomic) NSString * deviceID;
@property (strong, nonatomic) NSString * locationID;
@property (assign, nonatomic) CLProximity proximity;

+ (NSArray *)guestsFromJSON:(NSDictionary *)json;

@end
