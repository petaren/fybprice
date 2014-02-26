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
    context(@"when sent a date 2 minutes in the past", ^{
        NSDate *pastDate = [NSDate dateWithTimeIntervalSinceNow:-120];

        it(@"return formatted: 2 minutes ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] should] equal:@"2 minutes ago"];
        });

        it(@"should not return formatted: 2 hours ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"2 hours ago"];
        });

        it(@"should not return formatted: 1 minute ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"1 minute ago"];
        });
    });

    context(@"when sent a date 1 minute in the past", ^{
        NSDate *pastDate = [NSDate dateWithTimeIntervalSinceNow:-60];

        it(@"return formatted: 1 minute ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] should] equal:@"1 minute ago"];
        });

        it(@"should not return formatted: 2 minutes ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"2 minutes ago"];
        });

        it(@"should not return formatted: 1 hour ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"1 hour ago"];
        });
    });

    context(@"when sent a date 1 hour in the past", ^{
        NSDate *pastDate = [NSDate dateWithTimeIntervalSinceNow:-3600];

        it(@"return formatted: 1 hour ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] should] equal:@"1 hour ago"];
        });

        it(@"should not return formatted: 2 hours ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"2 hours ago"];
        });

        it(@"should not return formatted: 1 minute ago", ^{
            [[[TimeFormatter timeAgoSinceUpdate:pastDate] shouldNot] equal:@"1 minute ago"];
        });

    });
});

SPEC_END