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

#import "EbayProduct.h"
#import "EbayModel.h"

@implementation EbayProduct

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super initWithInfo:info];
    BOOL infoExists = IKNotNull(info);
    
    if (self && infoExists)
    {
        _isAutoPay = [[info[kIsAutoPay] objectAtIndex:0] boolValue];
        _country = [info[kCountry] objectAtIndex:0];
        _galleryPlusPictureURL = [info[kGalleryPlusPictureURL] objectAtIndex:0];
        _galleryURL = [info[kGalleryURL] objectAtIndex:0];
        _globalID = [info[kGlobalId] objectAtIndex:0];
        _isMultiVariationListing = [[info[kIsMultiVariationListing] objectAtIndex:0] boolValue];
        _listingInfo = [[EbayListingInfo alloc] initWithInfo:[info[kListingInfo] objectAtIndex:0]];
        _location = [info[kLocation] objectAtIndex:0];
        _patmentMethods = [NSArray arrayWithArray:info[kPaymentMethod]];
        _postalCode = [info[kPostalCode] objectAtIndex:0];
        
        _primaryCategory = [[EbayCategory alloc] initWithInfo:[info[kPrimaryCategory] objectAtIndex:0]];
        _secondaryCategory = [[EbayCategory alloc] initWithInfo:[info[kSecondaryCategory] objectAtIndex:0]];
        _isReturnAccepted = [[info[kIsReturnsAccepted] objectAtIndex:0] boolValue];

        _shippingInfo = [[EbayShippingInfo alloc] initWithInfo:[info[kShippingInfo] objectAtIndex:0]];
        _sellingStatus = [[EbaySellingStatus alloc] initWithInfo:[info[kSellingStatus] objectAtIndex:0]];
        _title = [info[kTitle] objectAtIndex:0];
        _isTopRatedListing = [[info[kIsTopRatedListing] objectAtIndex:0] boolValue];
        _viewItemURL = [info[kViewItemURL] objectAtIndex:0];
        
        return self;
    }
    return nil;
}

@end
