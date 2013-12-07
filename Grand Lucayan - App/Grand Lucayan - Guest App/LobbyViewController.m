//
//  LobbyViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "LobbyViewController.h"
#import "../../BeaconDefinitions.h"

@interface LobbyViewController ()
@property   (nonatomic, retain)     IBOutlet    UIImageView     *weather;
@property (weak, nonatomic) IBOutlet UILabel *proximity;
@end

@implementation LobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    self.navigationItem.title = dateString;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
#if TARGET_IPHONE_SIMULATOR
#else
    [self initRegions];
    
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.diningBeaconRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.spaBeaconRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.tennisBeaconRegion];
#endif
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:400 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.weather.frame = CGRectMake(-self.weather.frame.size.width+320, self.weather.frame.origin.y, self.weather.frame.size.width, self.weather.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Private methods

- (void)initRegions {
    // Dining
    NSUUID *uuidDining = [[NSUUID alloc] initWithUUIDString:diningUUID];
    self.diningBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidDining identifier:diningProximityID];
    [self.locationManager startMonitoringForRegion:self.diningBeaconRegion];
    
    // Spa
    NSUUID *uuidSpa = [[NSUUID alloc] initWithUUIDString:spaUUID];
    self.spaBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidSpa identifier:spaProximityID];
    [self.locationManager startMonitoringForRegion:self.spaBeaconRegion];
    
    // Tennis
    NSUUID *uuidTennis = [[NSUUID alloc] initWithUUIDString:tennisUUID];
    self.tennisBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidTennis identifier:tennisProximityID];
    [self.locationManager startMonitoringForRegion:self.tennisBeaconRegion];
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:diningProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.diningBeaconRegion];
    
    if ([region.identifier isEqualToString:spaProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.spaBeaconRegion];
    
    if ([region.identifier isEqualToString:tennisProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.tennisBeaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    
    if ([region.identifier isEqualToString:diningProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.diningBeaconRegion];
    
    if ([region.identifier isEqualToString:spaProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.spaBeaconRegion];
    
    if ([region.identifier isEqualToString:tennisProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.tennisBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    
    if ([region.identifier isEqualToString:diningProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.diningBeaconRegion];
    
    if ([region.identifier isEqualToString:spaProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.spaBeaconRegion];
    
    if ([region.identifier isEqualToString:tennisProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.tennisBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    NSString * beaconName = @"";
    if ([region.identifier isEqualToString:diningProximityID])
        beaconName = @"Churchill's";
    
    if ([region.identifier isEqualToString:spaProximityID])
        beaconName = @"Senses Spa";
    
    if ([region.identifier isEqualToString:tennisProximityID])
        beaconName = @"Tennis School";
        
    if (beacon.proximity == CLProximityUnknown) {
        NSLog(@"%@ beacon - Unknown Proximity", region.identifier);
        //self.proximity.text = [NSString stringWithFormat:@"%@ is UNKNOWN", beaconName];
    } else if (beacon.proximity == CLProximityImmediate) {
        NSLog(@"%@ beacon - Immediate", region.identifier);
        self.proximity.text = [NSString stringWithFormat:@"%@ is VERY CLOSE", beaconName];
    } else if (beacon.proximity == CLProximityNear) {
        NSLog(@"%@ beacon - Near", region.identifier);
        self.proximity.text = [NSString stringWithFormat:@"%@ is NEAR", beaconName];
    } else if (beacon.proximity == CLProximityFar) {
        NSLog(@"%@ beacon - Far", region.identifier);
        self.proximity.text = [NSString stringWithFormat:@"%@ is FAR", beaconName];
    }
}

@end
