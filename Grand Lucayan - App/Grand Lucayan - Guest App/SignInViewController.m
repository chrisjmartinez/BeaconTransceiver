//
//  SignInViewController.m
//  First Transit
//
//  Created by Graham Savage on 11/22/13.
//  Copyright (c) 2013 Centric Consulting. All rights reserved.
//

#import "SignInViewController.h"
#import "UIViewController+LookAndFeelCustomizations.h"
#import "ActivityViewController.h"

@interface SignInViewController ()
@property   (nonatomic, strong)     IBOutlet    UITextField     *username, *password;
- (IBAction)signIn:(id)sender;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeControlsForView:self.view];
}

- (IBAction)signIn:(id)sender {
    [ActivityViewController showActivityTitle:@"Signing In" message:@"Please Wait"];
    [self callWS];
}

- (void)callWS {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ActivityViewController hideActivity];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *tabs = [storyboard instantiateViewControllerWithIdentifier:@"LobbyViewController"];
            [self.navigationController pushViewController:tabs animated:YES];
        });
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.username) {
        [self.password becomeFirstResponder];
    } else if (textField == self.password) {
        [self.password resignFirstResponder];
    }
    return YES;
}

@end
