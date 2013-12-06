//
//  LobbyViewController.h
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LobbyViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *diningBeaconRegion;
@property (strong, nonatomic) CLBeaconRegion *spaBeaconRegion;
@property (strong, nonatomic) CLBeaconRegion *tennisBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
