//
//  SplashViewController.m
//  First Transit
//
//  Created by Graham Savage on 11/26/13.
//  Copyright (c) 2013 Centric Consulting. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()
@property   (nonatomic, retain)     IBOutlet    UIImageView     *logo;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.4 animations:^{
        CATransform3D transform = CATransform3DMakeTranslation(160, -160, 0);
        self.logo.layer.transform = CATransform3DScale(transform, 0.00001, 0.00001, 0.00001);
    } completion:^(BOOL finished) {
        UIViewController *home = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
        home.view.alpha = 0;
        [UIView animateWithDuration:.7 animations:^{
            home.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:home] animated:NO];
    }];
}

@end
