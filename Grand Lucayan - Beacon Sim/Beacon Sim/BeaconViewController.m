//
//  BeaconViewController.m
//  Beacon Sim
//
//  Created by Graham Savage on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "BeaconViewController.h"
#import "BeaconDefinitions.h"

@interface BeaconViewController ()
@property   (nonatomic, assign)  BOOL isTransmitting;
@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBeacon];
	[UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
#if TARGET_IPHONE_SIMULATOR
#else
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
#if TARGET_IPHONE_SIMULATOR
#else
    [self.peripheralManager stopAdvertising];
#endif
    self.isTransmitting = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:proximityUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:grandLucayaResort
                                                                minor:diningBeacon
                                                           identifier:diningProximityID];
}

#pragma mark - CBPeripheralManagerDelegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Beacon Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        self.isTransmitting = YES;
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Beacon Powered Off");
        [self.peripheralManager stopAdvertising];
        self.isTransmitting = NO;
    }
}

@end
