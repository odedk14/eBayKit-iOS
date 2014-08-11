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

#import "EbaySellingStatus.h"
#import "EbayModel.h"
@implementation EbaySellingStatus


- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    BOOL infoExists = IKNotNull(info);
    
    if (self && infoExists)
    {
        _bidCount = [[info[kBidCount] objectAtIndex:0] integerValue];
        _convertedCurrentPrice = [[EbayPrice alloc] initWithInfo:[info[kConvertedCurrentPrice] objectAtIndex:0]];
        _currentPrice = [[EbayPrice alloc] initWithInfo:[info[kCurrentPrice] objectAtIndex:0]];

        NSString* type = [info[kSellingState] objectAtIndex:0];
        
        if ([type isEqualToString:@"Active"])
            _sellingState = EbayKitSellingStateActive;
        else if ([type isEqualToString:@"Canceled"])
            _sellingState = EbayKitSellingStateCanceled;
        else if ([type isEqualToString:@"Ended"])
            _sellingState = EbayKitSellingStateEnded;
        else if ([type isEqualToString:@"EndedWithSales"])
            _sellingState = EbayKitSellingStateEndedWithSales;
        else
            _sellingState = EbayKitSellingStateEndedWithoutSales;
        
        NSString* time = [info[kTimeLeft] objectAtIndex:0];
        _timeLeft = [self parseISO8601Time:time];
        
        return self;
    }
    return nil;
    
}

- (NSString*)parseISO8601Time:(NSString*)duration
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSInteger seconds = 0;
    
    //Get Time part from ISO 8601 formatted duration http://en.wikipedia.org/wiki/ISO_8601#Durations
    duration = [duration substringFromIndex:[duration rangeOfString:@"T"].location];
    
    while ([duration length] > 1) { //only one letter remains after parsing
        duration = [duration substringFromIndex:1];
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:duration];
        
        NSString *durationPart = [[NSString alloc] init];
        [scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] intoString:&durationPart];
        
        NSRange rangeOfDurationPart = [duration rangeOfString:durationPart];
        
        duration = [duration substringFromIndex:rangeOfDurationPart.location + rangeOfDurationPart.length];
        
        if ([[duration substringToIndex:1] isEqualToString:@"H"]) {
            hours = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"M"]) {
            minutes = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"S"]) {
            seconds = [durationPart intValue];
        }
    }
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

@end
