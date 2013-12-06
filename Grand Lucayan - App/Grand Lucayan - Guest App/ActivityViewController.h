//
//  ActivityViewController.h
//  VitasSuite
//
//  Created by Graham Savage on 11/6/13.
//  Copyright (c) 2013 Vitas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController
@property   (nonatomic, strong)     IBOutlet    UILabel     *titleMsg, *message;
+ (void)showActivityTitle:(NSString *)title message:(NSString *)message;
+ (void)hideActivity;
@end
