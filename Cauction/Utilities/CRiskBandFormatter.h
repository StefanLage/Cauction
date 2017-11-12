//
//  CRiskBandFormatter.h
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAuction.h"

@interface CRiskBandFormatter : NSObject

+ (instancetype) shared;

/**
 *  Get corresponding RiskBand value for a risk define in string format
 *
 * @param riskString risk in string (e.g 'A+')
 *
 * @return RiskBand
 */
-(RiskBand)riskBandFromString:(NSString *) riskString;

/**
 *  Calculate the estimated return amount of an auction
 *
 *  @param auction client'd like to get the estimation
 *  @param bidAmount is the bid amount on the auction
 *
 *  @return double value equal to the era in GBP
 */
-(double) estimatedReturnAmount:(CAuction *)auction withBidAmount:(double) bidAmount;

@end
