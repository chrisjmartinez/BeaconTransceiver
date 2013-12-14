//
//  BeaconViewController.m
//  Beacon Sim
//
//  Created by Graham Savage on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "BeaconViewController.h"
#import "BeaconDefinitions.h"
#import "GuestsViewController.h"

@interface BeaconViewController ()
@property   (nonatomic, assign)  BOOL isTransmitting;
@property   (nonatomic, strong) GuestsViewController * guests;
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
}

- (void)displayGuests:(NSString *)locationID {
    NSString * storyBoard;
    
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        storyBoard = @"Main_iPhone";
    } else {
        storyBoard = @"Main_iPad";
    }
    
    self.guests = [[UIStoryboard storyboardWithName:storyBoard bundle: nil] instantiateViewControllerWithIdentifier:@"GuestsAtLocation"];
    
    self.guests.locationID = locationID;
    [self.navigationController pushViewController:self.guests animated:YES];
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
