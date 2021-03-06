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

@interface EbayModel : NSObject

@property (readonly) NSString* itemId;

- (id)initWithInfo:(NSDictionary *)info;

@end

#define kItemID @"itemId"

#define kEntriesPerPage @"entriesPerPage"
#define kPageNumber @"pageNumber"
#define kTotalEntries @"totalEntries"
#define kTotalPages @"totalPages"

#define kIsReturnsAccepted @"returnsAccepted"
#define kIsAutoPay @"autoPay"
#define kCountry @"country"
#define kGalleryPlusPictureURL @"galleryPlusPictureURL"
#define kGalleryURL @"galleryURL"
#define kGlobalId @"globalId"
#define kIsMultiVariationListing @"isMultiVariationListing"
#define kListingInfo @"listingInfo"
#define kLocation @"location"
#define kPaymentMethod @"paymentMethod"
#define kPostalCode @"postalCode"
#define kPrimaryCategory @"primaryCategory"
#define kSecondaryCategory @"secondaryCategory"
#define kSellingStatus @"sellingStatus"
#define kShippingInfo @"shippingInfo"
#define kTitle @"title"
#define kIsTopRatedListing @"topRatedListing"
#define kViewItemURL @"viewItemURL"

#define kIsBestOfferEnabled @"bestOfferEnabled"
#define kIsBuyItNowAvailable @"buyItNowAvailable"
#define kEndTime @"endTime"
#define kIsGift @"gift"
#define kStartTime @"startTime"
#define kListingType @"listingType"
#define kBuyItNowPrice @"buyItNowPrice"

#define kCategoryId @"categoryId"
#define kCategoryName @"categoryName"

#define kEbayCategoryID @"CategoryID"
#define kEbayCategoryName @"CategoryName"
#define kEbayCategoryParentID @"CategoryParentID"
#define kEbayLeafCategory @"LeafCategory"
#define kEbayCategoryIDPath @"CategoryIDPath"
#define kEbayCategoryNamePath @"CategoryNamePath"
#define kEbayCategoryLevel @"CategoryLevel"

#define kExpeditedShipping @"expeditedShipping"
#define kHandlingTime @"handlingTime"
#define kOneDayShippingAvailable @"oneDayShippingAvailable"
#define kShipToLocations @"shipToLocations"
#define kShippingServiceCost @"shippingServiceCost"
#define kShippingType @"shippingType"

#define kCurrencyId @"@currencyId"
#define kValue @"__value__"

#define kBidCount @"bidCount"
#define kConvertedCurrentPrice @"convertedCurrentPrice"
#define kCurrentPrice @"currentPrice"
#define kSellingState @"sellingState"
#define kTimeLeft @"timeLeft"

#define IKNotNull(obj) (obj && (![obj isEqual:[NSNull null]]) && (![obj isEqual:@"<null>"]) )
