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
#import "CConstants.h"

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

- (void)testWithExpectationCount:(NSUInteger)expCount initHandler:(nonnull void (^)(CAuctionsViewModel * viewModel))initHandler completion:(nonnull void (^)(CAuctionsViewModel * viewModel))completionHandler{
    XCTestExpectation *exp = [self expectationWithDescription:@"testCauctionViewModelReturnsAuctions"];
    [exp setExpectedFulfillmentCount:expCount];
    __block NSUInteger initAuctionsCount = 0;
    NSUInteger initRecurrentValue = expCount - 1;
    CAuctionsViewModel *viewModel = [[CAuctionsViewModel alloc] initWithApiClient:self.mockApiClient];
    [[viewModel.auctionsObserver deliverOnMainThread]
     subscribeNext:^(id _) {
         if (initAuctionsCount < initRecurrentValue){
             initAuctionsCount++;
             initHandler(viewModel);
         }
         else{
             completionHandler(viewModel);
         }
         [exp fulfill];
     }];
    // Wait for the observer
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testCauctionsViewModelReturnsAuctions {
    [self testWithExpectationCount:3 initHandler:^(CAuctionsViewModel * viewModel){
        XCTAssertEqual([viewModel auctionsInSection:0], 0);
    } completion:^(CAuctionsViewModel * viewModel){
        XCTAssertEqual([viewModel auctionsInSection:0], 2);
    }];
}

- (void)testCauctionsViewModelAuctionName {
    [self testWithExpectationCount:3 initHandler:^(CAuctionsViewModel * viewModel){
        XCTAssertEqual([viewModel auctionsInSection:0], 0);
    } completion:^(CAuctionsViewModel * viewModel){
        NSString *name = [viewModel auctionName:[NSIndexPath indexPathForItem:0 inSection:0]];
        XCTAssertTrue([name isEqualToString:@"foo"]);
    }];
}

- (void)testCauctionsViewModelAuctionEra {
    NSString *expEra = [NSString stringWithFormat:@"%.2f", (1 + 2.0f - 0.03f - 0.01f) * 20.0f];
    NSString *expEraTxt = [NSString stringWithFormat:Auction_Era_Text, expEra];

    [self testWithExpectationCount:3 initHandler:^(CAuctionsViewModel * viewModel){
        XCTAssertEqual([viewModel auctionsInSection:0], 0);
    } completion:^(CAuctionsViewModel * viewModel){
        NSString *era = [viewModel estimatedReturnAmountForAuction:[NSIndexPath indexPathForItem:1 inSection:0]];
        XCTAssertTrue([era isEqualToString:expEraTxt]);
    }];
}

@end
