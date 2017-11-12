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

- (NSString *)title;
- (NSUInteger)auctionsInSection:(NSInteger)section;
- (NSString *)auctionName:(NSIndexPath *)indexPath;

@end
