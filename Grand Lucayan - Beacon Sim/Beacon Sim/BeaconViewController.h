//
//  BeaconViewController.h
//  Beacon Sim
//
//  Created by Graham Savage on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeaconViewController : UIViewController <CBPeripheralManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@end
