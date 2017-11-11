//
//  CApiClient.h
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAuction;

@interface CApiClient : NSObject

/**
 * Request the API to get all auction available
 *
 * @param handler will contains a list of Auction if there is some, in case of any error this list will be nil and error object will be passed through
 */
- (void)getAuctionWithCompletion:(nonnull void (^)(NSArray<CAuction*> * _Nullable auctions))handler;

@end
