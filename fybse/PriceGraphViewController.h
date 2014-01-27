//
//  priceGraphViewController.h
//  fybse
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PricesModel.h"

@interface PriceGraphViewController : UIViewController <PricesModelDelegate>

-(void)refreshData;
-(void)stopUpdatingTimeSince;

@end
