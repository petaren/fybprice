//
//  pricesModel.h
//  fybse
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PricesModelDelegate <NSObject>

-(void)priceModelReceivedPrices:(NSMutableDictionary*)prices;

@end



@interface PricesModel : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) id delegate;

-(void)requestPrices;
-(void)cancelRequest;

@end
