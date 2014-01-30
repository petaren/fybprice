//
//  TimeFormatter.m
//  fybse
//
//  Created by Petar Mataic on 2014-01-30.
//  Copyright (c) 2014 Petar Mataic. All rights reserved.
//

#import "TimeFormatter.h"

@implementation TimeFormatter

+(NSString *)timeAgoSinceUpdate:(NSDate *)referenceDate
{
    NSTimeInterval diff = abs([referenceDate timeIntervalSinceNow]);
    if (diff < 3600) {
        NSInteger minsDiff = diff/60;
        return [NSString stringWithFormat:@"%ld minutes ago", (long)minsDiff];
    } else {
        NSInteger hoursDiff = diff/60/60;
        return [NSString stringWithFormat:@"%ld hour ago", (long)hoursDiff];
    }
}

@end
