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
    [self.apiClient getAuctionWithCompletion:^(id auctions, NSError *error) {
        XCTAssertNotNil(auctions, "testGet - testGet - the list of aucitons should be filled");
        XCTAssertNil(error, "testGet -error - there shouldn't have any errors");
        [exp fulfill];
    }];

    // Wait for the API response
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

@end
