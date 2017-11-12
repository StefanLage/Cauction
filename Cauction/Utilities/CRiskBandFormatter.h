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

-(RiskBand)riskBandFromString:(NSString *) riskString;
-(NSString *)stringFromRisk:(RiskBand) risk;

@end
