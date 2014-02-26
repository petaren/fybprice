//
//  TimeFormatter.h
//  fybse
//
//  Created by Petar Mataic on 2014-01-30.
//  Copyright (c) 2014 Petar Mataic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormatter : NSObject

+(NSString*)timeAgoSinceUpdate:(NSDate*)referenceDate;

@end
