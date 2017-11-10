//
//  NSURL+ApiFormat.h
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (ApiFormat)

+ (NSURL *) URLWithDomain:(NSString *)domain withEndPoint:(NSString *)endPoint;

@end
