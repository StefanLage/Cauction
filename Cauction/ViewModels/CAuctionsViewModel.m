//
//  CAuctionsViewModel.m
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CAuctionsViewModel.h"
#import "CApiClient.h"
#import "CAuction.h"
#import "CConstants.h"
#import "CRiskBandFormatter.h"

@interface CAuctionsViewModel()

@property (nonatomic, strong, readonly) CApiClient * apiClient;
@property (nonatomic, strong) NSArray<CAuction*> * auctions;

@end

@implementation CAuctionsViewModel

#pragma mark - Lifecycle

- (instancetype)initWithApiClient:(CApiClient *)apiClient{
    self = [super init];
    if (self){
        _apiClient = apiClient;
        _auctionsObserver = [RACObserve(self, auctions) mapReplace:@(YES)];
        [self loadAutions];
    }
    return self;
}

#pragma mark - Data loaders

- (void)loadAutions{
    [self.apiClient getAuctionWithCompletion:^(RACSignal * _Nullable auctions) {
        if (auctions){
            dispatch_async(dispatch_get_main_queue(), ^(void){
                // Set the value in the main thread
                RAC(self, auctions) = [auctions startWith:@[]];
            });
        }
    }];
}

#pragma mark - Datasource

- (NSString *) title{
    return Auctions_Title;
}

- (NSUInteger)auctionsInSection:(NSInteger)section{
    return self.auctions.count;
}

- (NSString *)auctionName:(NSIndexPath *)indexPath{
    CAuction *auction = [self auctionAtIndexPath:indexPath];
    return [auction.title copy];
}

- (NSString *)esimatedAmountTitleForAuction:(NSIndexPath *)indexPath{
    CAuction *auctionSelected = [self auctionAtIndexPath:indexPath];
    return [NSString stringWithFormat:Auction_Era_Title, auctionSelected.title];
}

- (NSString *)estimatedReturnAmountForAuction:(NSIndexPath *)indexPath{
    CAuction *auctionSelected = [self auctionAtIndexPath:indexPath];
    NSString *era = [NSString stringWithFormat:Auction_Era_Rounded, [[CRiskBandFormatter shared] estimatedReturnAmount:auctionSelected
                                                                                                         withBidAmount:Auctions_Bid_Amount_Default]];
    return [NSString stringWithFormat:Auction_Era_Text, era];
}

#pragma mark - Private

/**
 * Return the auction at indexpath specified
 */
- (CAuction *)auctionAtIndexPath:(NSIndexPath *)indexPath{
    return self.auctions[indexPath.row];
}

@end
