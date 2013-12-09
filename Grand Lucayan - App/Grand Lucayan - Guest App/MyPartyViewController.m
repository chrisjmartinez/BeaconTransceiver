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

@interface MyPartyViewController () <BaseWebserviceDelegate>
@property   (nonatomic, assign)     BOOL                isShowing;
@property   (nonatomic, retain)     GuestWebservice     *guestWS;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (self.isShowing) {
        }
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    self.isShowing = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - Service methods

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
}

- (void)serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
}

#pragma mark - Table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
