//
//  MyPartyViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/7/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "MyPartyViewController.h"
#import "BaseWebservice.h"
#import "GuestWebservice.h"
#import "LocationWebservice.h"
#import "CoreNetworkCommunicationResponse.h"
#import "Guest.h"
#import "BeaconDefinitions.h"

@interface MyPartyViewController () <BaseWebserviceDelegate>
@property   (nonatomic, assign)     BOOL                            isShowing;
@property   (nonatomic, retain)     GuestWebservice                 *guestWS;
@property   (nonatomic, retain)     IBOutlet            UITableView *table;
@property   (nonatomic, retain)     NSArray                         *guests;
@end

@implementation MyPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guestWS = [[GuestWebservice alloc] init];
    self.guestWS.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isShowing = YES;
    [self.guestWS getGuestsForAllLocations];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.isShowing = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - Service methods

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
    if (self.isShowing) {
        if (service.dictionary) {
            self.guests = [Guest guestsFromJSON:service.dictionary];
            //[self filterGuests];
            // Update the display with new data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
            // Fire another request after a one second pause
            [NSThread sleepForTimeInterval:2];
            [self.guestWS getGuestsForAllLocations];
        }
    }
}

- (void)filterGuests {
    NSMutableDictionary *collection = [NSMutableDictionary dictionary];
    for (Guest *guest in self.guests) {
        if ([collection objectForKey:guest.ID]) {
            Guest *existing = [collection objectForKey:guest.ID];
            if (guest.proximity < existing.proximity && guest.proximity != CLProximityUnknown) {
                [collection setObject:guest forKey:guest.ID];
            }
        } else {
            if (guest.ID) {
                [collection setObject:guest forKey:guest.ID];
            }
        }
    }
    NSMutableArray *filtered = [NSMutableArray array];
    for (Guest * guest in [collection allValues]) {
        [filtered addObject:guest];
    }
    self.guests = filtered;
}

- (void)serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
    NSLog(@"Error from getGuests %@", error.localizedDescription);
}

#pragma mark - Table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
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
