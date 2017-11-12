//
//  CAution.m
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CAuction.h"
#import "CRiskBandFormatter.h"

@implementation CAuction

- (instancetype) initWithId:(NSInteger)id title:(NSString*)title rate: (float)rate amountRate:(float)amountRate term:(NSInteger)term riskBand:(NSString*)riskBand closeTime:(NSDate*)closeTime{
    self = [super init];
    if (self){
        _id = id;
        _title = [title copy];
        _rate = rate;
        _amountCents = amountRate;
        _term = term;
        _riskBand = riskBand;
        _closeTime = [closeTime copy];
    }
    return self;
}

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}

- (RiskBand) riskBandValue {
    return [[CRiskBandFormatter shared] riskBandFromString:self.riskBand];
}

@end
