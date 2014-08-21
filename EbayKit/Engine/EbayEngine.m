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

#import "EbayEngine.h"
#import "AFNetworking.h"
#import "EbayPaginationOutput.h"
#import "EbayProduct.h"
#import "EbayModel.h"

NSString *const kEbayKitOpenApiBaseUrlConfigurationKey = @"EbayKitOpenApiBaseUrl";
NSString *const kEbayKitBaseUrlConfigurationKey = @"EbayKitBaseUrl";
NSString *const kInstagramKitAppClientIdConfigurationKey = @"EbayKitAppClientID";

NSString* const kEbayKitOpenApiBaseUrlDefault = @"http://open.api.ebay.com";
NSString *const kEbayKitBaseUrlDefault = @"http://svcs.ebay.com/services/";
//@"http://svcs.ebay.com/services/search/FindingService/v1?"

@interface EbayEngine ()
{
    dispatch_queue_t mBackgroundQueue;
}

+ (NSDictionary*) sharedEngineConfiguration;

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation EbayEngine

#pragma mark - Initializers -

+ (EbayEngine *)sharedEngine {
    static EbayEngine *_sharedEngine = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedEngine = [[EbayEngine alloc] init];
    });
    return _sharedEngine;
}

+ (EbayEngine *)sharedShoppingEngine
{
    static EbayEngine *_sharedEngine = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedEngine = [[EbayEngine alloc] initShopping];
    });
    return _sharedEngine;
}

+ (NSDictionary*) sharedEngineConfiguration {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"EbayKit" withExtension:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
    dict = dict ? dict : [[NSBundle mainBundle] infoDictionary];
    return dict;
}

- (id)init {
    if (self = [super init])
    {
        NSDictionary *sharedEngineConfiguration = [EbayEngine sharedEngineConfiguration];
        id url = nil;
        url = sharedEngineConfiguration[kEbayKitBaseUrlConfigurationKey]; //
        
        if (url) {
            url = [NSURL URLWithString:url];
        } else {
            url = [NSURL URLWithString:kEbayKitBaseUrlDefault]; // //kEbayKitOpenApiBaseUrlDefault
        }
        
        NSAssert(url, @"Base URL not valid: %@", sharedEngineConfiguration[kEbayKitBaseUrlConfigurationKey]);
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];

        self.appClientID =  sharedEngineConfiguration[kInstagramKitAppClientIdConfigurationKey];
        
        mBackgroundQueue = dispatch_queue_create("background", NULL);
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.operationManager.responseSerializer.acceptableContentTypes = [self.operationManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/plain", @"text/xml"]];
        
        BOOL validClientId = IKNotNull(self.appClientID) && ![self.appClientID isEqualToString:@""] && ![self.appClientID isEqualToString:@"<Client Id here>"];
        NSAssert(validClientId, @"Invalid Ebay Client ID.");
    }
    return self;
}

- (id) initShopping
{
    if (self = [super init])
    {
        NSDictionary *sharedEngineConfiguration = [EbayEngine sharedEngineConfiguration];
        id url = nil;
        url = sharedEngineConfiguration[kEbayKitOpenApiBaseUrlConfigurationKey]; //kEbayKitBaseUrlConfigurationKey
        
        if (url) {
            url = [NSURL URLWithString:url];
        } else {
            url = [NSURL URLWithString:kEbayKitOpenApiBaseUrlDefault]; //kEbayKitBaseUrlDefault //kEbayKitOpenApiBaseUrlDefault
        }
        
        NSAssert(url, @"Base URL not valid: %@", sharedEngineConfiguration[kEbayKitBaseUrlConfigurationKey]);
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        
        self.appClientID =  sharedEngineConfiguration[kInstagramKitAppClientIdConfigurationKey];
        
        mBackgroundQueue = dispatch_queue_create("background", NULL);
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.operationManager.responseSerializer.acceptableContentTypes = [self.operationManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/plain", @"text/xml"]];
        
        BOOL validClientId = IKNotNull(self.appClientID) && ![self.appClientID isEqualToString:@""] && ![self.appClientID isEqualToString:@"<Client Id here>"];
        NSAssert(validClientId, @"Invalid Ebay Client ID.");
    }
    return self;
}


//Check http://developer.ebay.com/Devzone/finding/CallRef/types/ItemFilterType.html for more info about itemFilter
- (void)getProductsWithKeywords:(NSString *)keywords
                     itemFilter:(NSDictionary*)itemFilter
                paginationInput:(EbayPaginationInput*)paginationInput
           useDescriptionSearch:(BOOL)useDescriptionSearch
                      sortOrder:(EbayKitSortOrder)sortOrder
                 outputSelector:(NSArray*)outputSelector
                    withSuccess:(EbayProductsBlock)success
                        failure:(EbayFailureBlock)failure
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"findItemsAdvanced" forKey:@"OPERATION-NAME"];
    [params setObject:self.appClientID forKey:@"SECURITY-APPNAME"];
    [params setObject:@"JSON" forKey:@"RESPONSE-DATA-FORMAT"];
    [params setObject:@"true" forKey:@"REST-PAYLOAD"];
    [params setObject:[[keywords stringByReplacingOccurrencesOfString:@" " withString:@"+"]stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding] forKey:@"keywords"];
    
    if (paginationInput)
    {
        if (paginationInput.entriesPerPage > 0)
        {
            [params setObject:[NSString stringWithFormat:@"%d", paginationInput.entriesPerPage] forKey:@"paginationInput.entriesPerPage"];
        }
        if (paginationInput.pageNumber > 0)
        {
            [params setObject:[NSString stringWithFormat:@"%d", paginationInput.pageNumber] forKey:@"paginationInput.pageNumber"];
        }
    }
    
    if (outputSelector)
    {
        for (NSString* value in outputSelector) {
            [params setObject:value forKey:@"outputSelector"];
        }
    }
    
    if (itemFilter)
    {
        [itemFilter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSAssert([key isKindOfClass:[NSString class]], @"itemFilter key is not a NSString");
            NSAssert([obj isKindOfClass:[NSArray class]], @"itemFilter object is not a NSArray");
            
            int index = [itemFilter.allKeys indexOfObject:key];
            [params setObject:key forKey:[NSString stringWithFormat:@"itemFilter(%d).name", index]];
            
            for (NSString* value in obj) {
                int valueIndex = [obj indexOfObject:value];
                [params setObject:value forKey:[NSString stringWithFormat:@"itemFilter(%d).value(%d)", index, valueIndex]];
            }
        }];
    }
    
    if (useDescriptionSearch)
    {
        [params setObject:@"true" forKey:@"descriptionSearch"];
    }
    
    if (sortOrder != EbayKitSortOrderNone)
    {
        [params setObject:[self sortOrderToString:sortOrder] forKey:@"sortOrder"];
    }
    
    //NSLog(@"%@", params);
    
    [self.operationManager GET:@"search/FindingService/v1"
                    parameters:params
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSDictionary* dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
                           NSArray* response = [dictionary objectForKey:@"findItemsAdvancedResponse"];
                           
                           NSDictionary* dic = [response objectAtIndex:0];
                           EbayPaginationOutput* paginationOutput = [[EbayPaginationOutput alloc] initWithInfo:[[dic objectForKey:@"paginationOutput"] objectAtIndex:0]];
                           
                           NSDictionary* itemsDictionary = [[dic objectForKey:@"searchResult"] objectAtIndex:0];
                           
                           NSMutableArray* items = [NSMutableArray arrayWithCapacity:[[itemsDictionary valueForKey:@"count"] integerValue]];
                           
                           for (NSDictionary* singleItemDic in [itemsDictionary valueForKey:@"item"]) {
                               EbayProduct* product = [[EbayProduct alloc] initWithInfo:singleItemDic];
                               [items addObject:product];
                           }
                           
                           //NSLog(@"%@", response);
                           success(items, paginationOutput);
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           failure(error);
                           
                       }];
}

#pragma mark -
#pragma mark - Shopping API

- (void)getCategoryInfoWithCategoryID:(NSInteger)categoryID
                          withSuccess:(EbayCategoriesBlock)success
                              failure:(EbayFailureBlock)failure
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"GetCategoryInfo" forKey:@"callname"];
    [params setObject:self.appClientID forKey:@"appid"];
    [params setObject:@"JSON" forKey:@"requestencoding"];
    [params setObject:@"785" forKey:@"version"];
    [params setObject:@"JSON" forKey:@"responseencoding"];
    [params setObject:[NSString stringWithFormat:@"%d", categoryID] forKey:@"CategoryID"];
    [params setObject:@"ChildCategories" forKey:@"IncludeSelector"];
    
    
    [self.operationManager GET:@"Shopping"
                    parameters:params
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSDictionary* dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
                           NSArray* categoriesResponse = [[dictionary objectForKey:@"CategoryArray"] valueForKey:@"Category"];
                           
                           NSMutableArray* categories = [NSMutableArray array];
                           for (NSDictionary* singleCategoryDic in categoriesResponse) {
                               EbayCategory* category = [[EbayCategory alloc] initWithCategoryInfo:singleCategoryDic];
                               [categories addObject:category];
                           }
                           
                           success(categories);
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           failure(error);
                       }];
}

- (NSString*) sortOrderToString:(EbayKitSortOrder)sortOrder
{
    switch (sortOrder) {
        case EbayKitSortOrderBestMatch:
            return @"BestMatch";
        case EbayKitSortOrderBidCountFewest:
            return @"BidCountFewest";
        case EbayKitSortOrderBidCountMost:
            return @"BidCountMost";
        case EbayKitSortOrderCountryAscending:
            return @"CountryAscending";
        case EbayKitSortOrderCountryDescending:
            return @"CountryDescending";
        case EbayKitSortOrderCurrentPriceHighest:
            return @"CurrentPriceHighest";
        case EbayKitSortOrderDistanceNearest:
            return @"DistanceNearest";
        case EbayKitSortOrderEndTimeSoonest:
            return @"EndTimeSoonest";
        case EbayKitSortOrderPricePlusShippingHighest:
            return @"PricePlusShippingHighest";
        case EbayKitSortOrderPricePlusShippingLowest:
            return @"PricePlusShippingLowest";
        case EbayKitSortOrderStartTimeNewest:
            return @"StartTimeNewest";
            default:
            return nil;
    }
}





@end
