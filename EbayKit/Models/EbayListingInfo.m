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

#import "EbayListingInfo.h"
#import "EbayModel.h"

@implementation EbayListingInfo

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    BOOL infoExists = IKNotNull(info);
    
    if (self && infoExists)
    {
        _isBestOfferEnabled = [[info[kIsBestOfferEnabled] objectAtIndex:0] boolValue];
        _isBuyItNowAvailable = [[info[kIsBuyItNowAvailable] objectAtIndex:0] boolValue];
        _endTime = [info[kEndTime] objectAtIndex:0];
        _startTime = [info[kStartTime] objectAtIndex:0];
        _isGift = [[info[kIsGift] objectAtIndex:0] boolValue];
        
        NSString* type = [info[kListingType] objectAtIndex:0];
        
        if ([type isEqualToString:@"AdFormat"])
            _listingType = kEbayKitListingTypeAdFormat;
        else if ([type isEqualToString:@"Auction"])
            _listingType = kEbayKitListingTypeAuction;
        else if ([type isEqualToString:@"AuctionWithBIN"])
            _listingType = kEbayKitListingTypeAuctionWithBIN;
        else if ([type isEqualToString:@"Classified"])
            _listingType = kEbayKitListingTypeClassified;
        else
            _listingType = kEbayKitListingTypeFixedPrice;
        
        if (_isBuyItNowAvailable)
            _buyItNowPrice = [[EbayPrice alloc] initWithInfo:[info[kBuyItNowPrice] objectAtIndex:0]];
        //TODO: Listing Type
        
        return self;
    }
    return nil;
}

@end
