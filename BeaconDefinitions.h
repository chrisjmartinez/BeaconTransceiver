//
//  BeaconDefinitions.h
//  Beacon Sim
//
//  Created by Chris Martinez on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#ifndef Beacon_Sim_BeaconDefinitions_h
#define Beacon_Sim_BeaconDefinitions_h

#import <CoreLocation/CoreLocation.h>

static NSString * proximityUUID = @"1AB2CA55-CADE-40F4-83B2-A1FE8C9FDEBE";

static NSString * diningProximityID = @"com.stokedsoftware.diningRegion";
static NSString * spaProximityID = @"com.stokedsoftware.spaRegion";
static NSString * tennisProximityID = @"com.stokedsoftware.tennisRegion";

static CLBeaconMajorValue grandLucayaResort = 1;

static CLBeaconMinorValue diningBeacon = 1;
static CLBeaconMinorValue spaBeacon = 2;
static CLBeaconMinorValue tennisBeacon = 3;

#endif
