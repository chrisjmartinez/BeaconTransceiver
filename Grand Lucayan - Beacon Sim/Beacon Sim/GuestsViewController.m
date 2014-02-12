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
    
    self.title = [NSString stringWithFormat:@"Guests at %@", [self displayNameForLocationID:self.locationID]];
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
            self.guests = [self sortByProximity:[Guest guestsFromJSON:service.dictionary]];

            // Update the display with new data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }
        
        // Fire another request after a five second pause
        [NSThread sleepForTimeInterval:5];
        [self.locationWS getGuestsForLocation:self.locationID];
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
    
    switch (guest.proximity) {
        case CLProximityUnknown:
            location.text = @"Location Unknown";
            location.textColor = [UIColor redColor];
            break;
            
        case CLProximityFar:
            location.text = @"Far";
            location.textColor = [UIColor blueColor];
            break;
            
        case CLProximityNear:
            location.text = @"Near";
            location.textColor = [UIColor orangeColor];
            break;
            
        case CLProximityImmediate:
            location.text = @"Very Close";
            location.textColor = [UIColor greenColor];
            break;
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

#pragma mark - Sorting

- (NSArray*)sortByProximity:(NSArray*)unsortedArray{
    NSArray *sortedByProximity = [unsortedArray sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2){
        Guest * guest1 = (Guest *)obj1;
        Guest * guest2 = (Guest *)obj2;
        
        if (!guest1 || !guest2) {
            return NSOrderedSame;
        }
        
        if (guest1.proximity < guest2.proximity) {
            return NSOrderedAscending;
        } else if (guest1.proximity > guest2.proximity) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return sortedByProximity;
}

@end
