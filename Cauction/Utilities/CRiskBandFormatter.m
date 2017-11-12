//
//  CRiskBandFormatter.m
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CRiskBandFormatter.h"

@interface CRiskBandFormatter()
@property (nonatomic, strong) NSDictionary *risks;
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

#pragma makr - Formatter

-(RiskBand)riskBandFromString:(NSString *) riskString{
    id riskBand = self.risks[riskString];
    if (!riskBand){
        // Default risk
        return D;
    }
    return [riskBand intValue];
}

-(NSString *)stringFromRisk:(RiskBand) risk{
    return [[self.risks allKeysForObject: @(risk)] firstObject];
}

@end
