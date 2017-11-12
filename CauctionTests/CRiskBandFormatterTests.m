//
//  CRiskBandFormatterTests.m
//  CauctionTests
//
//  Created by Stefan Lage on 12/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CRiskBandFormatter.h"

@interface CRiskBandFormatterTests : XCTestCase

@end

@implementation CRiskBandFormatterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRiskBandFromString {
    XCTAssertEqual([[CRiskBandFormatter shared] riskBandFromString:@"A"], A);
}

- (void)testEstimatedReturnAmount {
    CAuction *auction = [[CAuction alloc] initWithId:1
                                               title:@"foo"
                                                rate:1.0
                                          amountRate:1.0
                                                term:1
                                            riskBand:@"A+"
                                           closeTime:[NSDate new]];
    NSString *era = [NSString stringWithFormat:@"%.2f", [[CRiskBandFormatter shared] estimatedReturnAmount:auction withBidAmount:20.0]];
    NSString *expEra = [NSString stringWithFormat:@"%.2f", (1 + 1.0f - 0.01f - 0.01f) * 20.0f];
    XCTAssertTrue([era isEqualToString:expEra]);
}

@end
