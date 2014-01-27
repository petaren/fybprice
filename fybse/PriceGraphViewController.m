//
//  priceGraphViewController.m
//  fybse
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import "PriceGraphViewController.h"

@interface PriceGraphViewController ()
@property (nonatomic, strong) NSMutableDictionary *prices;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (nonatomic, strong) PricesModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (nonatomic, strong) NSTimer *timeSinceUpdateTimer;
@property (weak, nonatomic) IBOutlet UIView *lineChartView;

@end

@implementation PriceGraphViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.model = [[PricesModel alloc] init];
    self.model.delegate = self;
    [self.model requestPrices];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshData
{
    [self.model requestPrices];
}

-(void)stopUpdatingTimeSince
{
    [self.timeSinceUpdateTimer invalidate];
    self.timeSinceUpdateTimer = nil;
}

#pragma mark - PricesModelRequestDelegate

-(void)priceModelReceivedPrices:(NSMutableDictionary *)prices
{
    self.prices = prices;

    self.priceLabel.text = [((NSNumber*)self.prices[@"latest_sell"]) stringValue];
    self.avgLabel.text = [(NSNumber*)self.prices[@"average"] stringValue];
    self.highLabel.text = [(NSNumber*)[self.prices valueForKeyPath:@"high.value"] stringValue];
    self.lowLabel.text = [(NSNumber*)[self.prices valueForKeyPath:@"low.value"] stringValue];


    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter dateFromString:self.prices[@"latest_date"]];
    self.prices[@"latest_date"] = date;

    [self updateTimeSinceWithDate:date];

    self.timeSinceUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:30
                                                                 target:self
                                                               selector:@selector(timerFired:)
                                                               userInfo:date
                                                                repeats:YES];
    [self.timeSinceUpdateTimer setTolerance:10];
}

-(void)timerFired:(NSTimer*)timer
{
    [self updateTimeSinceWithDate:[timer userInfo]];
}

-(void)updateTimeSinceWithDate:(NSDate*)referenceDate
{
    NSTimeInterval diff = abs([referenceDate timeIntervalSinceNow]);
    if (diff < 3600) {
        NSInteger minsDiff = diff/60;
        self.lastUpdateLabel.text = [NSString stringWithFormat:@"%d minutes ago", minsDiff];
    } else {
        NSInteger hoursDiff = diff/60/60;
        self.lastUpdateLabel.text = [NSString stringWithFormat:@"%d hour ago", hoursDiff];
    }
    NSLog(@"Updated time since to: %@", self.lastUpdateLabel.text);
}


@end
