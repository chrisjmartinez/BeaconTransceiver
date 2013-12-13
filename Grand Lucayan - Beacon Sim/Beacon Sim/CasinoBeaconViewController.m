//
//  CasinoBeaconViewController.m
//  Beacon Sim
//
//  Created by Graham Savage on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "CasinoBeaconViewController.h"
#import "BeaconDefinitions.h"
@interface CasinoBeaconViewController ()

@end

@implementation CasinoBeaconViewController

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:ESTIMOTE_UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:PURPLE_1_MAJOR
                                                                minor:PURPLE_1_MINOR
                                                           identifier:casinoProximityID];
}

@end
