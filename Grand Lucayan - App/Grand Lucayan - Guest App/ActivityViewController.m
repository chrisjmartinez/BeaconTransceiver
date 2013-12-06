//
//  ActivityViewController.m
//  VitasSuite
//
//  Created by Graham Savage on 11/6/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()
@property   (nonatomic, strong)     IBOutlet    UIImageView *logo;
@end

@implementation ActivityViewController
ActivityViewController *activityVC = nil;
UIView *blanking = nil;

+ (void)showActivityTitle:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (activityVC) {
            activityVC.titleMsg.text = message;
            activityVC.message.text = title;
            return;
        }
        activityVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"ActivityViewController"];
        CGRect screenRect = [UIScreen mainScreen].bounds;
        
        blanking = [[UIView alloc] initWithFrame:screenRect];
        blanking.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:blanking];
        
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:activityVC.view];
        activityVC.view.frame = CGRectMake(screenRect.size.width/2 - activityVC.view.frame.size.width/2, screenRect.size.height/2 - activityVC.view.frame.size.height, activityVC.view.frame.size.width, activityVC.view.frame.size.height);
        activityVC.titleMsg.text = message;
        activityVC.message.text = title;
    });
}

+ (void)hideActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.25 animations:^{
            activityVC.view.layer.transform = CATransform3DMakeScale(.0001, .0001, 1);
            [blanking removeFromSuperview];
        } completion:^(BOOL finished) {
            [activityVC.view removeFromSuperview];
            activityVC = nil;
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.transform = CATransform3DMakeScale(.0001, .0001, 1);
    [UIView animateWithDuration:.25 animations:^{
        self.view.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [self startAnimation];
    }];
}

- (void)startAnimation {
    self.logo.layer.transform = CATransform3DMakeTranslation(0, 0, 100);
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
        self.logo.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:^(BOOL finished) {
    }];
}


@end
