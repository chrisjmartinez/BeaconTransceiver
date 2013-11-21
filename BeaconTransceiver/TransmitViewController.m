//
//  TransmitViewController.m
//  BeaconTransceiver
//
//  Created by Chris Martinez on 11/21/13.
//  Copyright (c) 2013 Chris Martinez. All rights reserved.
//

#import "TransmitViewController.h"
#import "Definitions.h"

@interface TransmitViewController ()

@end

@implementation TransmitViewController {
    BOOL isTransmitting;
}

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
    [self setLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)transmitBeacon:(id)sender {
    if (isTransmitting) {
        [self.peripheralManager stopAdvertising];
        isTransmitting = NO;
    } else {
        self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    }
}

#pragma mark - Private methods
- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:myUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.stokedsoftware.myRegion"];
}

- (void)setLabels {
    self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.minor];
    self.identityLabel.text = self.beaconRegion.identifier;
}

#pragma mark - CBPeripheralManagerDelegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        isTransmitting = YES;
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
        isTransmitting = NO;
    }
}

@end
