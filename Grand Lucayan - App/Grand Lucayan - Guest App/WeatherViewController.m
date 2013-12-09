//
//  WeatherViewController.m
//  Grand Lucayan - Guest App
//
//  Created by Graham Savage on 12/9/13.
//  Copyright (c) 2013 Grand Lucayan. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@property   (nonatomic, retain)     IBOutlet    UIWebView   *webView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.wunderground.com/global/stations/78062.html"]]];
}


@end
