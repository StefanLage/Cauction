//
//  CAuctionsViewModel.h
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class CApiClient;

@interface CAuctionsViewModel : NSObject

@property (nonatomic, readonly) RACSignal *auctionsObserver;

- (instancetype)initWithApiClient:(CApiClient *)apiClient;

/**
 * @return view controller's title
 */
- (NSString *)title;
/**
 * Return the number of auctions
 */
- (NSUInteger)auctionsInSection:(NSInteger)section;
/**
 * Get the auction's title at a specific position
 *
 * @param indexPath of the auction
 */
- (NSString *)auctionName:(NSIndexPath *)indexPath;
/**
 * Return the era's title for a specific position
 *
 * @param indexPath of the auction
 */
- (NSString *)esimatedAmountTitleForAuction:(NSIndexPath *)indexPath;
/**
 * Return the era of a specific position
 *
 * @param indexPath of the auction
 */
- (NSString *)estimatedReturnAmountForAuction:(NSIndexPath *)indexPath;

@end
