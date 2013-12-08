//
//  XCAsynchronousTestCase.h
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 12/8/13.
//  Copyright (c) 2013 Stoked Software, LLC.. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCAsynchronousTestCase : XCTestCase
- (void) startBlockWait;
- (void) endBlockWait;
- (void) waitForBlockToComplete;
- (void) waitForBlockToComplete:(NSInteger)withSeconds;
@end
