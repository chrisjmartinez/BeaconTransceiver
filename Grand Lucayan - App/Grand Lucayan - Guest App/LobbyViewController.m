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
CLProximity     lastDiningProximity;
CLProximity     lastSpaProximity;
    CLProximity     lastTennisProximity;
    CLProximity     lastCasinoProximity;
    CLProximity     lastGolfProximity;
}
@property   (strong, nonatomic)     CLBeaconRegion      *diningBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *spaBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *tennisBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *casinoBeaconRegion;
@property   (strong, nonatomic)     CLBeaconRegion      *golfBeaconRegion;
@property   (strong, nonatomic)     CLLocationManager   *locationManager;
@property   (nonatomic, retain)     IBOutlet    UIImageView     *weather;
@property   (weak, nonatomic)       IBOutlet    UIImageView     *spaLabel, *tennisLabel, *diningLabel, *casinoLabel, *golfLabel;
@property   (weak, nonatomic)       IBOutlet    UILabel         *forecast;
@property   (nonatomic, retain)     GuestWebservice     *guestWS;
@property   (nonatomic, retain)     PopupAdvertisementViewController    *advertisement;
@end

@implementation LobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today";
    
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
    
    lastDiningProximity = CLProximityUnknown;
    lastSpaProximity = CLProximityUnknown;
    lastTennisProximity = CLProximityUnknown;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *locationId = [prefs stringForKey:@"identifier_preference"];
    
    [self.guestWS putGuests:locationId location:diningProximityID proximity:[NSString stringWithFormat:@"%d", lastDiningProximity]];
    [self.guestWS putGuests:locationId location:spaProximityID proximity:[NSString stringWithFormat:@"%d", lastSpaProximity]];
    [self.guestWS putGuests:locationId location:tennisProximityID proximity:[NSString stringWithFormat:@"%d", lastTennisProximity]];
    [self.guestWS putGuests:locationId location:casinoProximityID proximity:[NSString stringWithFormat:@"%d", lastCasinoProximity]];
    [self.guestWS putGuests:locationId location:golfProximityID proximity:[NSString stringWithFormat:@"%d", lastGolfProximity]];
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
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:proximityUUID];
    
    // Dining
    self.diningBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:grandLucayaResort minor:diningBeacon identifier:diningProximityID];
    self.diningBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.diningBeaconRegion];
    
    // Spa
    self.spaBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:grandLucayaResort minor:spaBeacon identifier:spaProximityID];
    self.spaBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.spaBeaconRegion];
    
    // Tennis
    self.tennisBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid  major:grandLucayaResort minor:tennisBeacon identifier:tennisProximityID];
    self.tennisBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.tennisBeaconRegion];
    // Casino
    NSUUID *uuidEstimote = [[NSUUID alloc] initWithUUIDString:ESTIMOTE_UUID];
    self.casinoBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:PURPLE_1_MAJOR minor:PURPLE_1_MINOR identifier:casinoProximityID];
    self.casinoBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.casinoBeaconRegion];
    //self.casinoBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidEstimote major:PURPLE_2_MAJOR minor:PURPLE_2_MINOR identifier:casinoProximityID];
    //self.casinoBeaconRegion.notifyEntryStateOnDisplay = YES;
    //[self.locationManager startMonitoringForRegion:self.casinoBeaconRegion];
    
    // Golf
    self.golfBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidEstimote major:GREEN_1_MAJOR minor:GREEN_1_MINOR identifier:golfProximityID];
    self.golfBeaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.golfBeaconRegion];
    //self.golfBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidEstimote major:GREEN_2_MAJOR minor:GREEN_2_MINOR identifier:golfProximityID];
    //self.golfBeaconRegion.notifyEntryStateOnDisplay = YES;
    //[self.locationManager startMonitoringForRegion:self.golfBeaconRegion];
}

#pragma mark - LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self locationManager:manager didEnterRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    if ([region.identifier isEqualToString:diningProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.diningBeaconRegion];
    
    if ([region.identifier isEqualToString:spaProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.spaBeaconRegion];
    
    if ([region.identifier isEqualToString:tennisProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.tennisBeaconRegion];
    
    if ([region.identifier isEqualToString:casinoProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.casinoBeaconRegion];
    
    if ([region.identifier isEqualToString:golfProximityID])
        [self.locationManager startRangingBeaconsInRegion:self.golfBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    
    if ([region.identifier isEqualToString:diningProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.diningBeaconRegion];
    
    if ([region.identifier isEqualToString:spaProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.spaBeaconRegion];
    
    if ([region.identifier isEqualToString:tennisProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.tennisBeaconRegion];
    
    if ([region.identifier isEqualToString:casinoProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.casinoBeaconRegion];
    
    if ([region.identifier isEqualToString:golfProximityID])
        [self.locationManager stopRangingBeaconsInRegion:self.golfBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [beacons firstObject];

    if ([region.identifier isEqualToString:diningProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.diningLabel identifier:region];
    } else if ([region.identifier isEqualToString:spaProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.spaLabel identifier:region];
    } else if ([region.identifier isEqualToString:tennisProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.tennisLabel identifier:region];
    } else if ([region.identifier isEqualToString:casinoProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.casinoLabel identifier:region];
    } else if ([region.identifier isEqualToString:golfProximityID]) {
        [self setProximityOnButton:beacon andLabel:self.golfLabel identifier:region];
    }
    [self showAdvertisementForBeacon:beacon region:region];
}

- (void)showAdvertisementForBeacon:(CLBeacon *)beacon region:(CLBeaconRegion *)region {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *name = [prefs stringForKey:@"identifier_preference"];
    
    if (self.navigationController.topViewController != self) {
        // Supress ad if lobby is not showing
        return;
    }
    if (self.advertisement && ![self.advertisement.region.identifier isEqualToString:region.identifier]) {
        // If ad is already showing for a different beacon, do nothing
        return;
    }
    if (!self.advertisement && (beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate)) {
        if ([region.identifier isEqualToString:casinoProximityID] || [region.identifier isEqualToString:golfProximityID]) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.advertisement = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopupAdvertisementViewController"];
            self.advertisement.delegate = self;
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
                self.advertisement.message.text = @"Hi XXXX,\n\nCome and enjoy a wonderful meal at Churchill's";
                self.advertisement.photo.image = [UIImage imageNamed:@"DiningPhoto"];
                self.advertisement.titleLabel.text = @"Churchill's Restaurant";
            }
            if (name != nil) {
                self.advertisement.message.text = [self.advertisement.message.text stringByReplacingOccurrencesOfString:@"XXXX" withString:name];
            }
            [UIView animateWithDuration:.3 animations:^{
                self.advertisement.view.alpha = 1;
            } completion:^(BOOL finished) {
            }];
            AudioServicesPlaySystemSound(soundFileObject);
        });
    } else if (self.advertisement && beacon.proximity != CLProximityNear && beacon.proximity != CLProximityImmediate) {
        [self closeAdvertisement];
    }
}

- (void)closeAdvertisement {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.advertisement.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.advertisement.view removeFromSuperview];
            self.advertisement = nil;
        }];
    });
}

- (void)advertisement:(PopupAdvertisementViewController *)ad wasTouched:(UITouch *)touch {
    //    [self closeAdvertisement];
}

- (void)setProximityOnButton:(CLBeacon *)beacon andLabel:(UIImageView *)label identifier:(CLBeaconRegion *)region {
    UIImage *image = [UIImage imageNamed:@"ProximityIndicatorNotNear"];
    CLProximity proximity = CLProximityUnknown;
    
    if (beacon) {
        proximity = beacon.proximity;
    }

    switch (proximity) {
        case CLProximityUnknown:
        default:
            image = [UIImage imageNamed:@"ProximityIndicatorNotNear"];
            break;
            
        case CLProximityImmediate:
            image = [UIImage imageNamed:@"ProximityIndicatorVeryNear"];
            break;
            
        case CLProximityNear:
            image = [UIImage imageNamed:@"ProximityIndicatorNear"];
            break;
            
        case CLProximityFar:
            image = [UIImage imageNamed:@"ProximityIndicatorFar"];
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        label.image = image;
    });
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *locationId = [prefs stringForKey:@"identifier_preference"];
    
    // only tell the server if something has changed, your battery thanks you
    if (beacon && [beacon.major intValue] == PURPLE_1_MAJOR) {
        if (proximity != lastCasinoProximity) {
            lastCasinoProximity = proximity;
            [self.guestWS putGuests:locationId location:region.identifier proximity:[NSString stringWithFormat:@"%d", proximity]];
        }
    }
    if (beacon && [beacon.major intValue] == GREEN_1_MAJOR) {
        if (proximity != lastGolfProximity) {
            lastGolfProximity = proximity;
            [self.guestWS putGuests:locationId location:region.identifier proximity:[NSString stringWithFormat:@"%d", proximity]];
        }
    }
    if (beacon && [beacon.major intValue] == grandLucayaResort) {
        if ([beacon.minor intValue] == diningBeacon) {
            if (proximity != lastDiningProximity) {
                lastDiningProximity = proximity;
                [self.guestWS putGuests:locationId location:region.identifier proximity:[NSString stringWithFormat:@"%d", proximity]];
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
                    [self showBackgroundAlertForBeacon:beacon region:region];
                }
            }
        } else if ([beacon.minor intValue] == spaBeacon) {
            if (proximity != lastSpaProximity) {
                lastSpaProximity = proximity;
                [self.guestWS putGuests:locationId location:region.identifier proximity:[NSString stringWithFormat:@"%d", proximity]];
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
                    [self showBackgroundAlertForBeacon:beacon region:region];
                }
            }
        } else if ([beacon.minor intValue] == tennisBeacon) {
            if (proximity != lastTennisProximity) {
                lastTennisProximity = proximity;
                [self.guestWS putGuests:locationId location:region.identifier proximity:[NSString stringWithFormat:@"%d", proximity]];
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
                    [self showBackgroundAlertForBeacon:beacon region:region];
                }
            }
        }
    }
}

- (void)showBackgroundAlertForBeacon:(CLBeacon *)beacon region:(CLBeaconRegion *)region {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *name = [prefs stringForKey:@"identifier_preference"];
    
    if (beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UILocalNotification *alert = [[UILocalNotification alloc] init];
            alert.alertAction = @"Grand Lucayan";
            if ([region.identifier isEqualToString:spaProximityID]) {
                alert.alertBody = @"Hi XXXX, The Senses Spa has an opening for a pedicure right now.";
            } else if ([region.identifier isEqualToString:tennisProximityID]) {
                alert.alertBody = @"Hi XXXX, Don't forget your tennis lesson with Jake in 35 minutes.";
            } else if ([region.identifier isEqualToString:diningProximityID]) {
                alert.alertBody = @"Hi XXXX, Come and enjoy a wonderful meal at Churchill's";
            }
            alert.alertBody = [alert.alertBody stringByReplacingOccurrencesOfString:@"XXXX" withString:name];
            alert.applicationIconBadgeNumber = 1;
            alert.soundName = @"Alert.m4a";
            [[UIApplication sharedApplication] presentLocalNotificationNow:alert];
        });
    }
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
