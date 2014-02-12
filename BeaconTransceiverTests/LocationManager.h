//
//  LocationManager.h
//  Connect
//
//  Created by Chris Martinez on 11/13/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationAddress : NSObject
@property (nonatomic, strong) NSString * street;
@property (nonatomic, strong) NSString * street2;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * zipCode;
@end

@protocol LocationManagerDelegate <NSObject>
- (void) didUpdateLocationWithAddress:(CLLocation *)location address:(LocationAddress *)address;
- (void) didFailLocationUpdate:(NSError *)error;
@end

@interface LocationManager : NSObject<CLLocationManagerDelegate>

+ (LocationManager *)sharedLocationManager;

- (void) refresh;

@property (copy, readwrite) CLLocation * location;
@property (assign, nonatomic) BOOL isLocationAvailable;
@property (nonatomic, strong) id <LocationManagerDelegate> delegate;
@property (nonatomic, strong) LocationAddress * address;

@end
