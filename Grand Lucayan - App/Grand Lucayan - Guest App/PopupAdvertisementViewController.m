//
//  PopupAdvertisementViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/10/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "PopupAdvertisementViewController.h"

@interface PopupAdvertisementViewController ()
@end

@implementation PopupAdvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advertisement:wasTouched:)]) {
        [self.delegate performSelector:@selector(advertisement:wasTouched:) withObject:self withObject:[touches anyObject]];
    }
}

- (void)advertisement:(PopupAdvertisementViewController *)ad wasTouched:(UITouch *)touch {}
@end
