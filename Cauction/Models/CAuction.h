//
//  CAuction.h
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface CAuction : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) float rate;
@property (nonatomic) float amountCents;
@property (nonatomic) NSInteger term;
@property (nonatomic) NSString *riskBand;
@property (nonatomic) NSDate *closeTime;

@end
