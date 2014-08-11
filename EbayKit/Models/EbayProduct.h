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
#import "EbayModel.h"
#import "EbayListingInfo.h"
#import "EbayCategory.h"
#import "EbayShippingInfo.h"
#import "EbaySellingStatus.h"

@interface EbayProduct : EbayModel

@property (nonatomic, readonly) BOOL isAutoPay;
@property (nonatomic) NSString* country;
@property (nonatomic) NSString* galleryPlusPictureURL;
@property (nonatomic) NSString* galleryURL;
@property (nonatomic) NSString* globalID;
@property (nonatomic, readonly) BOOL isMultiVariationListing;
@property (nonatomic) EbayListingInfo* listingInfo;
@property (nonatomic) NSString* location;
@property (nonatomic) NSArray* patmentMethods;
@property (nonatomic) NSString* postalCode;
@property (nonatomic) EbayCategory* primaryCategory;
@property (nonatomic) EbayCategory* secondaryCategory;
@property (nonatomic) EbayShippingInfo* shippingInfo;
@property (nonatomic) EbaySellingStatus* sellingStatus;

@property (nonatomic, readonly) BOOL isReturnAccepted;
@property (nonatomic) NSString* title;
@property (nonatomic, readonly) BOOL isTopRatedListing;
@property (nonatomic) NSString* viewItemURL;

- (id) initWithInfo:(NSDictionary*)info;

@end
