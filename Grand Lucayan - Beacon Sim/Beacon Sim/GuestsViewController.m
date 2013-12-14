//
//  GuestsViewController.m
//  Beacon Sim
//
//  Created by Chris Martinez on 12/13/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "GuestsViewController.h"
#import "LocationWebservice.h"
#import "Guest.h"
#import "CoreNetworkCommunicationResponse.h"
#import "BeaconDefinitions.h"

@interface GuestsViewController () <BaseWebserviceDelegate>
@property (nonatomic, assign) BOOL            isShowing;
@property (nonatomic, retain) LocationWebservice *  locationWS;
@property (nonatomic, retain) NSArray *             guests;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation GuestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationWS = [[LocationWebservice alloc] init];
    self.locationWS.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isShowing = YES;
    [self.locationWS getGuestsForLocation:self.locationID];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.isShowing = NO;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Service methods

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
    if (self.isShowing) {
        if (200 == response.status && service.dictionary) {
            self.guests = [Guest guestsFromJSON:service.dictionary];

            // Update the display with new data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
            // Fire another request after a five second pause
            [NSThread sleepForTimeInterval:5];
            [self.locationWS getGuestsForLocation:self.locationID];
        }
    }
}

- (void) serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
    NSLog(@"serviceCallDidFailWithError - %@", error.localizedFailureReason);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.guests.count;
}

#pragma mark - Table methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"GuestCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Guest *guest = [self.guests objectAtIndex:indexPath.row];
    UIImageView *face = (UIImageView *)[cell viewWithTag:1];
    face.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Icon", guest.ID]];
    UILabel *name = (UILabel *)[cell viewWithTag:2];
    name.text = guest.ID;
    UILabel *location = (UILabel *)[cell viewWithTag:3];
    if (guest.proximity == CLProximityUnknown) {
        location.text = @"Location Unknown";
        location.textColor = [UIColor redColor];
    } else {
        location.text = [NSString stringWithFormat:@"Nearest place: %@", [self displayNameForLocationID:guest.locationID]];
        location.textColor = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:1];
    }
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSString *)displayNameForLocationID:(NSString *)locationID {
    if ([locationID isEqualToString:spaProximityID]) {
        return @"Senses Spa";
    } else if ([locationID isEqualToString:tennisProximityID]) {
        return @"Tennis Pro Shop";
    } else if ([locationID isEqualToString:diningProximityID]) {
        return @"Churchill's";
    } else if ([locationID isEqualToString:casinoProximityID]) {
        return @"Casino";
    } else if ([locationID isEqualToString:golfProximityID]) {
        return @"Golf Course";
    }
    return locationID;
}

@end
