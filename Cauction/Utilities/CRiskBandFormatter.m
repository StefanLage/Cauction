//
//  CRiskBandFormatter.m
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CRiskBandFormatter.h"
#import "CConstants.h"

@interface CRiskBandFormatter()
@property (nonatomic, strong) NSDictionary *risks;
@property (nonatomic, strong) NSDictionary *risksEstimatedBadDebt;
@end

@implementation CRiskBandFormatter

#pragma makr - Lifecycle
-(instancetype) init {
    self = [super init];
    if (self){
        // UGLY
        _risks = @{
                   @"A+": @(APlus),
                   @"A": @(A),
                   @"B": @(B),
                   @"C": @(C),
                   @"D": @(D)
                   };
        _risksEstimatedBadDebt = @{
                                   @(APlus): @(0.01),
                                   @(A): @(0.02),
                                   @(B): @(0.03),
                                   @(C): @(0.04),
                                   @(D): @(0.05),
                                   };
        
    }
    return self;
}

+ (instancetype) shared{
    static CRiskBandFormatter *unique = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unique = [[self alloc] init];
    });
    return unique;
}

#pragma mark - Formatter

-(RiskBand)riskBandFromString:(NSString *) riskString{
    id riskBand = self.risks[riskString];
    if (!riskBand){
        // Default risk
        return D;
    }
    return [riskBand intValue];
}

#pragma mark - Estimated return amount

/**
 *  Calculate the estimated return amount of an auction
 *
 *  @param auction client'd like to get the estimation
 *  @param bidAmount is the bid amount on the auction
 *
 *  @return double value equal to the era in GBP
 *
 *  era = (1 + ar - ebd - f) * ba
 *
 *  where:
 *      is the estimated return amount in GBP.
 *      is the auction's rate.
 *      is the estimated bad debt associated to the auction's risk band (see table).
 *      is the fee, default is 0.01.
 *      is the bid amount, default is £20.
 */
-(double) estimatedReturnAmount:(CAuction *)auction withBidAmount:(double) bidAmount{
    double ar = auction.rate;
    double ebd = [self estimatedBadDebt:auction.riskBandValue];
    double era = (1 + ar - ebd - Auctions_Fee_Default) * bidAmount;
    return era;
}

#pragma mark - Private

-(double) estimatedBadDebt:(RiskBand)riskBand{
    return [self.risksEstimatedBadDebt[@(riskBand)] doubleValue];
}

@end
