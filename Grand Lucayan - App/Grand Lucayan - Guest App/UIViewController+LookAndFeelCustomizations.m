//
//  UIViewController+LookAndFeelCustomizations.m
//  VitasSuite
//
//  Created by Graham Savage on 10/17/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import "UIViewController+LookAndFeelCustomizations.h"

// These UI customizations are those that we need globally but cannot be done using appearance API - see AppDelegate for the appearance API ussage
@implementation UIViewController (LookAndFeelCustomizations)

- (void)customizeControlsForView:(UIView *)view {
    NSArray *controls = [view subviews];
    for (UIView *control in controls) {
        if ([control isKindOfClass:[UITextField class]]) {
            ((UITextField *)control).leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 10)];
            ((UITextField *)control).leftViewMode = UITextFieldViewModeAlways;
            ((UITextField *)control).font = [UIFont fontWithName:@"Avenir-Roman" size:15];
            ((UITextField *)control).layer.cornerRadius = 10;
            //((UITextField *)control).layer.shadowOpacity = 0.3;
            ((UITextField *)control).layer.borderWidth = 0.5;
            ((UITextField *)control).layer.borderColor = [[UIColor colorWithWhite:0.25 alpha:1] CGColor];
            ((UITextField *)control).backgroundColor = [UIColor whiteColor];
            [((UITextField *)control) setTextColor:[UIColor blackColor]];
        } else if ([control isKindOfClass:[UIButton class]]) {
            ((UIButton *)control).titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:15];
        } else if ([control isKindOfClass:[UITableView class]]) {
            ((UITextField *)control).layer.shadowOpacity = 0.3;
            ((UITextField *)control).backgroundColor = [UIColor whiteColor];
        } else if ([control isKindOfClass:[UIView class]]) {
            [self customizeControlsForView:control];
        }
    }
}
@end
