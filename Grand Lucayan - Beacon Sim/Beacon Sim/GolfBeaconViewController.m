//
//  GolfBeaconViewController.m
//  Beacon Sim
//
//  Created by Graham Savage on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "GolfBeaconViewController.h"
#import "BeaconDefinitions.h"

@interface GolfBeaconViewController ()

@end

@implementation GolfBeaconViewController

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:ESTIMOTE_UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:GREEN_1_MAJOR
                                                                minor:GREEN_1_MINOR
                                                           identifier:golfProximityID];
}

- (IBAction)tapGolfBeacon:(id)sender {
    [self displayGuests:golfProximityID];
}

@end
