//
//  CApiClientTests.m
//  CauctionTests
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CApiClient.h"

@interface CApiClientTests : XCTestCase

@property (nonatomic, strong) CApiClient * apiClient;

@end

@implementation CApiClientTests

- (void)setUp {
    [super setUp];
    self.apiClient = [CApiClient new];
}

- (void)tearDown {
    self.apiClient = nil;
    [super tearDown];
}

- (void)testGet {
    XCTestExpectation *exp = [self expectationWithDescription:@"testGet"];
    [self.apiClient getAuctionWithCompletion:^(NSArray<CAuction*> * auctions) {
        XCTAssertNotNil(auctions, "testGet - auctions - the list of aucitons should be filled");
        XCTAssertEqual(auctions.count, 17, "testGet - We should have 17 items");
        [exp fulfill];
    }];

    // Wait for the API response
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

@end
