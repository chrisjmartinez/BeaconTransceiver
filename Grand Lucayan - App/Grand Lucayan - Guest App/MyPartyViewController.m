//
//  MyPartyViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/7/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "MyPartyViewController.h"

@interface MyPartyViewController ()

@end

@implementation MyPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

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
