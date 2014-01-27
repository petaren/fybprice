//
//  pricesModel.m
//  fybse
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import "PricesModel.h"

@interface PricesModel()

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSMutableData *requestData;

@end

@implementation PricesModel

static NSString *const URL = @"http://petar.se:3000/prices";

-(id)init
{
    self = [super init];
    if (self) {
        self.url = [NSURL URLWithString:URL];
    }

    return self;
}

-(void)requestPrices
{
    self.request = [[NSURLRequest alloc] initWithURL:self.url
                                         cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                     timeoutInterval:30.0];

    self.requestData = [NSMutableData new];
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];

    NSLog(@"Began getting bitcoin prices");
}

-(void)cancelRequest
{
    [self.connection cancel];
    self.requestData = nil;
    self.connection = nil;
    self.request = nil;

    NSLog(@"The request was canceled");
}

-(void)callDelegate
{
    if ([self.delegate respondsToSelector:@selector(priceModelReceivedPrices:)]) {
        NSError *error;
        NSMutableDictionary *pricesObj = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"Error parsing json data: %@", error);
            return;
        }
        [self.delegate priceModelReceivedPrices:pricesObj];
    }
}

#pragma mark - NSURLConnection delegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.requestData = nil;
    self.connection = nil;
    self.request = nil;

    NSLog(@"The connection failed with error: %@", error);

    // TODO: report error
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.requestData appendData:data];

    NSLog(@"The connection delivered partial data");
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    NSLog(@"The connection responded with HTTP status code: %ld", (long)[response statusCode]);
    if ([response statusCode] != 200) {
        [connection cancel];
        self.requestData = nil;
        NSLog(@"The connection was canceled because the status code was not code 200");
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self callDelegate];

    NSLog(@"The connection finished, num bytes: %lu", (unsigned long)[self.requestData length]);
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSLog(@"Cached response");
    return cachedResponse;
}

@end
