//
//  PopupAdvertisementViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/10/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "PopupAdvertisementViewController.h"

@interface PopupAdvertisementViewController ()
@property   (nonatomic, retain)     IBOutlet    UILabel     *titleLabel, *message;
@property   (nonatomic, retain)     IBOutlet    UIImageView *photo;
@end

@implementation PopupAdvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *name = [prefs stringForKey:@"identifier_preference"];
    self.message.text = [self.message.text stringByReplacingOccurrencesOfString:@"XXXX" withString:name];
}


@end
