//
//      Copyright (c) 2014 Oded Klein. All rights reserved.
//
//      Permission is hereby granted, free of charge, to any person obtaining a copy
//      of this software and associated documentation files (the "Software"), to deal
//      in the Software without restriction, including without limitation the rights
//      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//      copies of the Software, and to permit persons to whom the Software is
//      furnished to do so, subject to the following conditions:
//
//      The above copyright notice and this permission notice shall be included in all
//      copies or substantial portions of the Software.
//
//      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//      SOFTWARE.

#import <Foundation/Foundation.h>
#import "EbayPrice.h"
typedef enum
{
    kEbayKitListingTypeAdFormat,
    kEbayKitListingTypeAuction,
    kEbayKitListingTypeAuctionWithBIN,
    kEbayKitListingTypeClassified,
    kEbayKitListingTypeFixedPrice,
    
} EbayKitListingType;

@interface EbayListingInfo : NSObject

@property (nonatomic, readonly) BOOL isBestOfferEnabled;
@property (nonatomic, readonly) BOOL isBuyItNowAvailable;
@property (nonatomic, readonly) BOOL isGift;
@property (nonatomic, readonly) NSDate* startTime;
@property (nonatomic, readonly) NSDate* endTime;
@property (nonatomic, readonly) EbayPrice* buyItNowPrice;
@property (nonatomic, readonly) EbayKitListingType listingType;

- (id) initWithInfo:(NSDictionary*)info;

@end
