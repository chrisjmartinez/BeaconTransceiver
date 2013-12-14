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

@interface GuestsViewController () <BaseWebserviceDelegate>
@property (nonatomic, retain) LocationWebservice *  locationWS;
@property (nonatomic, retain) NSArray *             guests;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation GuestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.locationWS = [[LocationWebservice alloc] init];
    self.locationWS.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.locationWS getGuestsForLocation:self.locationID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Service methods

- (void)serviceCallDidFinishLoading:(BaseWebservice *)service withResponse:(CoreNetworkCommunicationResponse *)response {
    if (200 == response.status && service.dictionary) {
        self.guests = [Guest guestsFromJSON:service.dictionary];

        // Update the display with new data
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
        // Fire another request after a one second pause
        [NSThread sleepForTimeInterval:2];
        [self.locationWS getGuestsForLocation:self.locationID];
    }
}

- (void) serviceCallDidFailWithError:(BaseWebservice *)service withError:(NSError *)error {
    NSLog(@"serviceCallDidFailWithError - %@", error.localizedFailureReason);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;  // immediate, near, far
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
