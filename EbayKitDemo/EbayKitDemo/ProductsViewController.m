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

#import "ProductsViewController.h"
#import "ProductTableViewCell.h"
#import "EbayProduct.h"
#import "UIImageView+WebCache.h"
#import "EbayEngine.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[EbayEngine sharedEngine] getCategoryInfoWithCategoryID:1249
                                                 withSuccess:^(NSArray *categories) {
                                                     
                                                 }
                                                     failure:^(NSError *error) {
                                                         
                                                     }];
    /*
    NSDictionary* filter = @{@"ListingType": @[@"Auction"]};
    
    NSArray* outputSelector = self.includeSellerInfo ? @[@"SellerInfo"] : nil;
    
    EbayPaginationInput* paginationInput = [[EbayPaginationInput alloc] initWithEntriesPerPage:100 pageNumber:1];
    
    [[EbayEngine sharedEngine] getProductsWithKeywords:self.keywords
                                            itemFilter:filter
                                       paginationInput:paginationInput
                                  useDescriptionSearch:YES
                                             sortOrder:EbayKitSortOrderBestMatch
                                        outputSelector:outputSelector
                                           withSuccess:^(NSArray *products, EbayPaginationOutput* paginationOutput) {
                                               
                                               self.products = products;
                                               [self.tableView reloadData];
                                           }
                                               failure:^(NSError *error) {
                                                   NSLog(@"%@", error);
                                               }];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    EbayProduct* product = [self.products objectAtIndex:indexPath.row];
    cell.product = product;
    
    [cell.productGalleryImageView setImage:nil];
    [cell.productGalleryImageView setImageWithURL:[NSURL URLWithString:product.galleryURL]];
    
    [cell.lblProductTitle setText:product.title];
    [cell.lblProductTitle sizeToFit];
    
    NSString* type;
    switch (product.listingInfo.listingType) {
        case kEbayKitListingTypeAdFormat:
            type = @"AdFormat";
            break;
        case kEbayKitListingTypeAuction:
            type = @"Auction";
            break;
        case kEbayKitListingTypeAuctionWithBIN:
            type = @"AuctionWithBIN";
            break;
        case kEbayKitListingTypeClassified:
            type = @"Classified";
            break;
        default:
            type = @"Fixed";
            break;
    }
    
    [cell.lblProductSellingType setText:type];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
