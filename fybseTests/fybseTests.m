//
//  fybseTests.m
//  fybseTests
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "TimeFormatter.h"

SPEC_BEGIN(TimeFormatterSpec)

describe(@"Time formatter", ^{
    context(@"when sent a date", ^{
        NSDate *pastDate = [NSDate dateWithTimeIntervalSinceNow:-120];
        it(@"returns a formatted time since that date", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] should] equal:@"2 minutes ago"];
        });
    });
});

SPEC_END