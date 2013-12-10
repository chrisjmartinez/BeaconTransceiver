//
//  LobbyViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "LobbyViewController.h"
#import "BeaconDefinitions.h"
#import "BaseWebservice.h"
#import "GuestWebservice.h"
#import "LocationWebservice.h"
#import "CoreNetworkCommunicationResponse.h"
#import "PopupAdvertisementViewController.h"

@interface LobbyViewController () <BaseWebserviceDelegate> {
CFURLRef		soundFileURLRef;
SystemSoundID	soundFileObject;
}
@property   (strong, nonatomic)     CLBeaconRegion      *diningBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *spaBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *tennisBeaconRegion;
@property   (strong, nonatomic)     CLLocationManager   *locationManager;
@property   (nonatomic, retain)     IBOutlet    UIImageView     *weather;
@property   (weak, nonatomic)       IBOutlet    UIImageView     *spaLabel, *tennisLabel, *diningLabel;
@property   (weak, nonatomic)       IBOutlet    UILabel         *forecast;
@property   (nonatomic, retain)     GuestWebservice     *guestWS;
@property   (nonatomic, retain)     PopupAdvertisementViewController    *advertisement;
@end

@implementation LobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    self.navigationItem.title = dateString;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
#if TARGET_IPHONE_SIMULATOR
#else
    [self initRegions];
#endif
    self.guestWS = [[GuestWebservice alloc] init];
    self.guestWS.delegate = self;

    soundFileURLRef = (__bridge CFURLRef)([[NSBundle mainBundle] URLForResource: @"Alert" withExtension: @"m4a"]);
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundFileObject);
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
    self.diningBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.diningBeaconRegion];
    
    // Spa
    NSUUID *uuidSpa = [[NSUUID alloc] initWithUUIDString:spaUUID];
    self.spaBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidSpa identifier:spaProximityID];
    self.spaBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.spaBeaconRegion];
    
    // Tennis
    NSUUID *uuidTennis = [[NSUUID alloc] initWithUUIDString:tennisUUID];
    self.tennisBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidTennis identifier:tennisProximityID];
    self.tennisBeaconRegion.notifyEntryStateOnDisplay = YES;
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
    CLBeacon *beacon = [beacons firstObject];

    if ([region.identifier isEqualToString:diningProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.diningLabel identifier:region.identifier];
    } else if ([region.identifier isEqualToString:spaProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.spaLabel identifier:region.identifier];
    } else if ([region.identifier isEqualToString:tennisProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.tennisLabel identifier:region.identifier];
    }
    [self showAdvertisementForBeacon:beacon region:region];
}

- (void)showAdvertisementForBeacon:(CLBeacon *)beacon region:(CLBeaconRegion *)region {
    if (self.advertisement && ![self.advertisement.region.identifier isEqualToString:region.identifier]) {
        // If ad is already showing for a different beacon, do nothing
        return;
    }
    
    if (!self.advertisement && (beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AudioServicesPlaySystemSound(soundFileObject);
            self.advertisement = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopupAdvertisementViewController"];
            self.advertisement.region = region;
            self.advertisement.view.alpha = 0;
            [self.view.window.rootViewController.view addSubview:self.advertisement.view];
            if ([region.identifier isEqualToString:spaProximityID]) {
                self.advertisement.message.text = @"Hi XXXX,\n\nThe Senses Spa has an opening for a pedicure right now.\nWould you like to have this before your massage appointment in 30 minutes?\n\nJust walk on in";
                self.advertisement.photo.image = [UIImage imageNamed:@"SpaPhoto"];
                self.advertisement.titleLabel.text = @"Senses Spa & Fitness Center";
            } else if ([region.identifier isEqualToString:tennisProximityID]) {
                self.advertisement.message.text = @"Hi XXXX,\n\nDon't forget your tennis lesson with Jake in 35 minutes.";
                self.advertisement.photo.image = [UIImage imageNamed:@"TennisPhoto"];
                self.advertisement.titleLabel.text = @"Tennis Pro Shop";
            } else if ([region.identifier isEqualToString:diningProximityID]) {
            }
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *name = [prefs stringForKey:@"identifier_preference"];
            self.advertisement.message.text = [self.advertisement.message.text stringByReplacingOccurrencesOfString:@"XXXX" withString:name];
            [UIView animateWithDuration:.3 animations:^{
                self.advertisement.view.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        });
    } else if (self.advertisement && beacon.proximity != CLProximityNear && beacon.proximity != CLProximityImmediate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.3 animations:^{
                self.advertisement.view.alpha = 0;
            } completion:^(BOOL finished) {
                [self.advertisement.view removeFromSuperview];
                self.advertisement = nil;
            }];
        });
    }
}

- (void)setProximityOnButton:(CLBeacon *)beacon andLabel:(UIImageView *)label identifier:(NSString *)identifier {
    UIImage *image = [UIImage imageNamed:@"ProximityIndicatorNotNear"];
    if (!beacon || beacon.proximity == CLProximityUnknown) {
        image = [UIImage imageNamed:@"ProximityIndicatorNotNear"];
    } else if (beacon.proximity == CLProximityImmediate) {
        image = [UIImage imageNamed:@"ProximityIndicatorVeryNear"];
    } else if (beacon.proximity == CLProximityNear) {
        image = [UIImage imageNamed:@"ProximityIndicatorNear"];
    } else if (beacon.proximity == CLProximityFar) {
        image = [UIImage imageNamed:@"ProximityIndicatorFar"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        label.image = image;
    });
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *locationId = [prefs stringForKey:@"identifier_preference"];
    [self.guestWS putGuests:locationId location:locationId proximity:[NSString stringWithFormat:@"%d", beacon.proximity]];
}

- (void)flashImage:(UIImageView *)imageView {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Service methods

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
}

- (void)serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
}

@end
