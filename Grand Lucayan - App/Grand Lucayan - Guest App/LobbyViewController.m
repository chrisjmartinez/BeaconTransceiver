//
//  LobbyViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/6/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "LobbyViewController.h"

@interface LobbyViewController ()
@property   (nonatomic, retain)     IBOutlet    UIImageView     *weather;
@end

@implementation LobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:400 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.weather.frame = CGRectMake(-self.weather.frame.size.width, self.weather.frame.origin.y, self.weather.frame.size.width, self.weather.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

@end
