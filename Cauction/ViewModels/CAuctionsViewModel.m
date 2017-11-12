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
    return @"Auctions";
}

- (NSUInteger)auctionsInSection:(NSInteger)section{
    return self.auctions.count;
}

- (NSString *)auctionName:(NSIndexPath *)indexPath{
    CAuction *auction = [self auctionAtIndexPath:indexPath];
    return [NSString stringWithFormat:@"%@", auction.title];
}

#pragma mark - Private

- (CAuction *)auctionAtIndexPath:(NSIndexPath *)indexPath{
    return self.auctions[indexPath.row];
}

@end
