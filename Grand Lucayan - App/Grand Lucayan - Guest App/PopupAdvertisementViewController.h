//
//  PopupAdvertisementViewController.h
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/10/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PopupAdvertisementViewController : UIViewController
@property   (nonatomic, retain)     IBOutlet    UIImageView *photo;
@property   (nonatomic, retain)     IBOutlet    UILabel     *titleLabel, *message;
@property   (nonatomic, retain)     CLBeaconRegion          *region;
@property   (nonatomic, retain)     id                      delegate;

- (void)advertisement:(PopupAdvertisementViewController *)ad wasTouched:(UITouch *)touch;
@end
