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

#import "EbayShippingInfo.h"
#import "EbayModel.h"

@implementation EbayShippingInfo

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    BOOL infoExists = IKNotNull(info);
    
    if (self && infoExists)
    {
        _isExpeditedShipping = [[info[kExpeditedShipping] objectAtIndex:0] boolValue];
        _handlingTime = [[info[kHandlingTime] objectAtIndex:0] integerValue];
        _isOneDayShippingAvailable = [[info[kOneDayShippingAvailable] objectAtIndex:0] boolValue];
        _shipToLocations = [NSArray arrayWithArray:info[kShipToLocations]];

        NSString* type = [info[kShippingType] objectAtIndex:0];

        if ([type isEqualToString:@"Calculated"])
            _shippingType = kEbayKitShippingTypeCalculated;
        else if ([type isEqualToString:@"CalculatedDomesticFlatInternational"])
            _shippingType = kEbayKitShippingTypeCalculatedDomesticFlatInternational;
        else if ([type isEqualToString:@"Flat"])
            _shippingType = kEbayKitShippingTypeFlat;
        else if ([type isEqualToString:@"FlatDomesticCalculatedInternational"])
            _shippingType = kEbayKitShippingTypeFlatDomesticCalculatedInternational;
        else if ([type isEqualToString:@"Free"])
            _shippingType = kEbayKitShippingTypeFree;
        else if ([type isEqualToString:@"FreePickup"])
            _shippingType = kEbayKitShippingTypeFreePickup;
        else if ([type isEqualToString:@"Freight"])
            _shippingType = kEbayKitShippingTypeFreight;
        else if ([type isEqualToString:@"FreightFlat"])
            _shippingType = kEbayKitShippingTypeFreightFlat;
        else
            _shippingType = kEbayKitShippingTypeNotSpecified;
        
        NSDictionary* dic = [info[kShippingServiceCost] objectAtIndex:0];
        
        if (dic)
        {
            _price = [[EbayPrice alloc] initWithInfo:dic];
        }
        return self;
    }
    return nil;
    
}

@end
