//
//  CategoriesViewController.m
//  EbayKitDemo
//
//  Created by Oded Klein on 8/17/14.
//  Copyright (c) 2014 Oded Klein. All rights reserved.
//

#import "CategoriesViewController.h"
#import "EbayEngine.h"
#import "EbayCategory.h"

@interface CategoriesViewController ()

@property (strong, nonatomic) NSMutableArray* categories;

@end

@implementation CategoriesViewController

- (id)initWithStyle:(UITableViewStyle)style andCategoryID:(NSNumber*)aCategoryID andTitle:(NSString*)aTitle;
{
    self = [super initWithStyle:style];
    if (self) {
        self.categoryID = [aCategoryID intValue];
        self.title = aTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CategoryCell"];
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self loadCategories];
}

- (void) loadCategories
{
    //Calling this method will get all sub categories of the category id.
    //If -1 is passed, the root category and its first childs will be retrieved as well.
    NSAssert(self.categoryID != 0 && self.categoryID > -2, @"Not a valid category ID");
    
    [[EbayEngine sharedShoppingEngine] getCategoryInfoWithCategoryID:self.categoryID
                withSuccess:^(NSArray *categories) {
                    self.categories = [NSMutableArray arrayWithArray:[categories subarrayWithRange:NSMakeRange(1, categories.count-1)]];
                    [self.tableView reloadData];
                }
                failure:^(NSError *error) {
                    NSLog(@"%@", error);
                }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.categories) return 0;
    
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    EbayCategory* category = [self.categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = category.categoryName;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Category id: %@", category.categoryId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = category.isLeaf ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EbayCategory* category = [self.categories objectAtIndex:indexPath.row];

    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    CategoriesViewController* categoriesViewController = [[CategoriesViewController alloc] initWithStyle:self.tableView.style andCategoryID:[formatter numberFromString:category.categoryId] andTitle:category.categoryName];
    [self.navigationController pushViewController:categoriesViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EbayCategory* category = [self.categories objectAtIndex:indexPath.row];

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:category.categoryName message:[NSString stringWithFormat:@"Category id: %@", category.categoryId] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

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
