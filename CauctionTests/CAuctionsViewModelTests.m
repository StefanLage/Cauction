//
//  CAuctionsViewModel.m
//  CauctionTests
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CAuctionsViewModel.h"
#import "CApiClient.h"
#import "CAuction.h"

#pragma mark - Mock CApiClient
@interface CApiClientMock : CApiClient
@end

@implementation CApiClientMock

- (void)getAuctionWithCompletion:(nonnull void (^)(RACSignal * _Nullable auctions))handler{
    NSArray<CAuction*> * mockAuctions = @[
                                          [[CAuction alloc] initWithId:1 title:@"foo" rate:1.0 amountRate:1.0 term:1 riskBand:@"A+" closeTime:[NSDate new]],
                                          [[CAuction alloc] initWithId:1 title:@"bar" rate:2.0 amountRate:2.0 term:2 riskBand:@"B" closeTime:[[NSDate alloc] initWithTimeIntervalSinceNow:3600]]
                                          ];
    handler([RACSignal return:mockAuctions]);
}

@end


#pragma mark - CAuctionsViewModelTests
@interface CAuctionsViewModelTests : XCTestCase

@property (nonatomic, strong) CApiClientMock *mockApiClient;

@end

@implementation CAuctionsViewModelTests

- (void)setUp {
    [super setUp];
    self.mockApiClient = [[CApiClientMock alloc] init];
}

- (void)tearDown {
    self.mockApiClient = nil;
    [super tearDown];
}

- (void)testCauctionViewModelReturnsAuctions {
    XCTestExpectation *exp = [self expectationWithDescription:@"testCauctionViewModelReturnsAuctions"];
    [exp setExpectedFulfillmentCount:3];
    __block NSUInteger initAuctionsCount = 0;
    CAuctionsViewModel *viewModel = [[CAuctionsViewModel alloc] initWithApiClient:self.mockApiClient];
    [[viewModel.auctionsObserver deliverOnMainThread]
     subscribeNext:^(id _) {
         if (initAuctionsCount < 2){
             // First two calls are just initialising the array
             initAuctionsCount++;
             XCTAssertEqual([viewModel auctionsInSection:0], 0);
         }
         else{
             XCTAssertEqual([viewModel auctionsInSection:0], 2);
         }
         [exp fulfill];
     }];
    // Wait for the observer
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testCauctionViewModelAuctionName {
    XCTestExpectation *exp = [self expectationWithDescription:@"testCauctionViewModelAuctionName"];
    [exp setExpectedFulfillmentCount:3];
    __block NSUInteger initAuctionsCount = 0;
    CAuctionsViewModel *viewModel = [[CAuctionsViewModel alloc] initWithApiClient:self.mockApiClient];
    [[viewModel.auctionsObserver deliverOnMainThread]
     subscribeNext:^(id _) {
         if (initAuctionsCount < 2){
             // First two calls are just initialising the array
             initAuctionsCount++;
             XCTAssertEqual([viewModel auctionsInSection:0], 0);
         }
         else{
             NSString *name = [viewModel auctionName:[NSIndexPath indexPathForItem:0 inSection:0]];
             XCTAssertTrue([name isEqualToString:@"foo"]);
         }
         [exp fulfill];
     }];
    // Wait for the observer
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

@end
