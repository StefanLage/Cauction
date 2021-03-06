//
//  CApiClient.m
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CApiClient.h"
#import "AFNetworking.h"
#import "NSURL+ApiFormat.h"
#import "CConstants.h"

#import "CAuction.h"

#pragma mark - Network Service
@protocol CNetworkingService
- (void) get:(nonnull NSString *)endPoint completion:(nonnull void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nonnull error))handler;
@end

#pragma mark - CApiClient

@interface CApiClient() <CNetworkingService>
@property (nonatomic, strong, readonly) AFURLSessionManager *sessionManager;
@end

@implementation CApiClient

- (instancetype) init{
    self = [super init];
    if (self){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

#pragma mark - CNetworkingService implementation

- (void) get:(nonnull NSString *)endPoint completion:(nonnull void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nonnull error))handler{
    NSURL *url = [NSURL URLWithDomain:BaseUri withEndPoint:endPoint];
    NSURLRequest *request = [self defaultRequest:url];

    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request
                                                        completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                            handler(response, responseObject, error);
                                                        }];
    [task resume];
}

#pragma mark - Public

- (void)getAuctionWithCompletion:(nonnull void (^)(RACSignal * _Nullable auctions))handler{
    [self get:AuctionEndpoint completion:^(NSURLResponse * _Nullable response, NSDictionary *  _Nullable responseObject, NSError * _Nonnull error) {
        if (responseObject){
            // Serialize and return the list of auctions
            NSError * jsonError;
            NSArray <CAuction*> *auctions = [CAuction arrayOfModelsFromDictionaries:responseObject[AuctionEndpoint_AuctionsNestedKey] error:&jsonError];
            handler([RACSignal return:auctions]);
        }
        else{
            // should hanlde error itself -> using log service or something
            handler(nil);
        }
    }];
}

#pragma mark - Private

- (NSURLRequest *)defaultRequest:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:AcceptValue forHTTPHeaderField:AcceptKey];
    return request;
}

@end
