//
//  SpaBeaconViewController.m
//  Beacon Sim
//
//  Created by Chris Martinez on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "SpaBeaconViewController.h"
#import "BeaconDefinitions.h"

@interface SpaBeaconViewController () {
    BOOL isTransmitting;
}

@end

@implementation SpaBeaconViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initBeacon];
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
    isTransmitting = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:spaUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.stokedsoftware.spaRegion"];
}

#pragma mark - CBPeripheralManagerDelegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Spa Beacon Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        isTransmitting = YES;
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Spa Beacon Powered Off");
        [self.peripheralManager stopAdvertising];
        isTransmitting = NO;
    }
}

@end
