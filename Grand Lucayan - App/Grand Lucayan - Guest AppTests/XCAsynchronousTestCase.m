//
//  XCAsynchronousTestCase.m
//  CoreNetworkCommunicationLibrary
//
//  Created by Chris Martinez on 12/8/13.
//  Copyright (c) 2013 Stoked Software, LLC.. All rights reserved.
//

#import "XCAsynchronousTestCase.h"

@implementation XCAsynchronousTestCase {
    __block BOOL waitingForBlock;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void) startBlockWait {
    waitingForBlock = YES;
}

- (void) endBlockWait {
    waitingForBlock = NO;
}

- (void) waitForBlockToComplete {
    [self waitForBlockToComplete:INT32_MAX]; // wait a long time
}

- (void) waitForBlockToComplete:(NSInteger)withSeconds {
    NSInteger timeout = 0;
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        
        if (timeout > withSeconds)
            [self endBlockWait];
        else
            timeout++;
    }
}

@end
