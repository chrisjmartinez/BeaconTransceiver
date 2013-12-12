//
//  BeaconManager.m
//  Grand Lucayan - Guest App
//
//  Created by Chris Martinez on 12/12/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "BeaconManager.h"
#import "BeaconDefinitions.h"

@interface BeaconManager()  <CLLocationManagerDelegate>
@property   (strong, nonatomic)     CLLocationManager * locationManager;
@property   (strong, nonatomic)     NSMutableSet *      beaconRegions;
@end

@implementation BeaconManager

SINGLETON_GCD(BeaconManager)

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        self.beaconRegions = [NSMutableSet set];
    }
    
    return self;
}

- (void)addBeaconRegion:(CLBeaconRegion *)beaconRegion {
    [self.beaconRegions addObject:beaconRegion];
    
    beaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:beaconRegion];
}

- (void)removeBeaconRegion:(CLBeaconRegion *)beaconRegion {
    [self.locationManager stopMonitoringForRegion:beaconRegion];
    [self.beaconRegions removeObject:beaconRegion];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    for (CLBeaconRegion * beaconRegion in self.beaconRegions) {
        if ([region.identifier isEqualToString:beaconRegion.identifier]) {
            [self.locationManager startRangingBeaconsInRegion:beaconRegion];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    for (CLBeaconRegion * beaconRegion in self.beaconRegions) {
        if ([region.identifier isEqualToString:beaconRegion.identifier]) {
            [self.locationManager startRangingBeaconsInRegion:beaconRegion];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    for (CLBeaconRegion * beaconRegion in self.beaconRegions) {
        if ([region.identifier isEqualToString:beaconRegion.identifier]) {
            [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [beacons firstObject];
    
    for (CLBeaconRegion * beaconRegion in self.beaconRegions) {
        if ([region.identifier isEqualToString:beaconRegion.identifier]) {
            /*
            if ([region.identifier isEqualToString:diningProximityID]) {
                [self setProximityOnButton:beacon andLabel:self.diningLabel identifier:region];
            } else if ([region.identifier isEqualToString:spaProximityID]) {
                [self setProximityOnButton:beacon andLabel:self.spaLabel identifier:region];
            } else if ([region.identifier isEqualToString:tennisProximityID]) {
                [self setProximityOnButton:beacon andLabel:self.tennisLabel identifier:region];
            }
            [self showAdvertisementForBeacon:beacon region:region];
             */
        }
    }
}

@end
