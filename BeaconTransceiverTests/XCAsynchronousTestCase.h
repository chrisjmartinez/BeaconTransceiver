//
//  XCAsynchronousTestCase.h
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 10/4/13.
//  Copyright (c) 2013 VITAS Healthcare Corporation. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCAsynchronousTestCase : XCTestCase
- (void) startBlockWait;
- (void) endBlockWait;
- (void) waitForBlockToComplete;
- (void) waitForBlockToComplete:(NSInteger)withSeconds;
@end
