//
//  SpaBeaconViewController.m
//  Beacon Sim
//
//  Created by Chris Martinez on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "SpaBeaconViewController.h"
#import "BeaconDefinitions.h"


@implementation SpaBeaconViewController

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:proximityUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:grandLucayaResort
                                                                minor:spaBeacon
                                                           identifier:spaProximityID];
}

@end
