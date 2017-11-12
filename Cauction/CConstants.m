//
//  CConstants.m
//  Cauction
//
//  Created by Stefan Lage on 10/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CConstants.h"

// API ENDPOINTS
NSString * const BaseUri = @"http://fc-ios-test.herokuapp.com";
NSString * const AuctionEndpoint = @"auctions";

// HTTP HEADERS KEYS
NSString * const AcceptKey = @"Accept";
NSString * const AcceptValue = @"application/json";

// JSON KEYS
NSString * const AuctionEndpoint_AuctionsNestedKey = @"items";

// VIEWCONTROLLER TITLES
NSString * const Auctions_Title = @"Auctions";

// DEFAULT VALUES
float const Auctions_Fee_Default = 0.01f;
float const Auctions_Bid_Amount_Default = 20.0f;
NSString * const Auction_Era_Rounded = @"%.2f";
NSString * const Auction_Era_Title = @"%@'s ERA";
NSString * const Auction_Era_Text = @"£%@";
NSString * const Alert_Default_Button_Text = @"OK";
