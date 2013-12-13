//
//  DiningBeaconViewController.m
//  Beacon Sim
//
//  Created by Chris Martinez on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "DiningBeaconViewController.h"
#import "BeaconDefinitions.h"

@implementation DiningBeaconViewController

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:proximityUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:grandLucayaResort
                                                                minor:diningBeacon
                                                           identifier:diningProximityID];
}

@end
