//
//  NSURL+ApiFormat.m
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "NSURL+ApiFormat.h"

@implementation NSURL (ApiFormat)

+ (NSURL *) URLWithDomain:(NSString *)domain withEndPoint:(NSString *)endPoint{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", domain, endPoint]];
}

@end
