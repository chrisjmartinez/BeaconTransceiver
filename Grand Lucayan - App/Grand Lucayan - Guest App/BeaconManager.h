//
//  BeaconManager.h
//  Grand Lucayan - Guest App
//
//  Created by Chris Martinez on 12/12/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconManager : NSObject <CLLocationManagerDelegate>

+ (BeaconManager *)sharedBeaconManager;
- (void)addBeaconRegion:(CLBeaconRegion *)beaconRegion;
- (void)removeBeaconRegion:(CLBeaconRegion *)beaconRegion;

@end
