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

static NSString *ESTIMOTE_UUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
// Purple 1
static CLBeaconMajorValue PURPLE_1_MAJOR = 56855;
static CLBeaconMinorValue PURPLE_1_MINOR = 4957;
// Green 1
static CLBeaconMajorValue GREEN_1_MAJOR = 10844;
static CLBeaconMinorValue GREEN_1_MINOR = 32455;
// Blue 1
static CLBeaconMajorValue BLUE_1_MAJOR = 46520;
static CLBeaconMinorValue BLUE_1_MINOR = 29264;

// Purple 2
static CLBeaconMajorValue PURPLE_2_MAJOR = 13386;
static CLBeaconMinorValue PURPLE_2_MINOR = 13299;
// Green 2
static CLBeaconMajorValue GREEN_2_MAJOR = 26214;
static CLBeaconMinorValue GREEN_2_MINOR = 61068;
// Blue 2
static CLBeaconMajorValue BLUE_2_MAJOR = 38886;
static CLBeaconMinorValue BLUE_2_MINOR = 52070;







static NSString * proximityUUID = @"1AB2CA55-CADE-40F4-83B2-A1FE8C9FDEBE";
static NSString * diningProximityID = @"com.stokedsoftware.diningRegion";
static NSString * spaProximityID = @"com.stokedsoftware.spaRegion";
static NSString * tennisProximityID = @"com.stokedsoftware.tennisRegion";
static CLBeaconMajorValue grandLucayaResort = 1;
static CLBeaconMinorValue diningBeacon = 1;
static CLBeaconMinorValue spaBeacon = 2;
static CLBeaconMinorValue tennisBeacon = 3;

#endif
