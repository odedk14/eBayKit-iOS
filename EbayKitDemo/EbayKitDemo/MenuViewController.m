//
//  MenuViewController.m
//  EbayKitDemo
//
//  Created by Oded Klein on 8/17/14.
//  Copyright (c) 2014 Oded Klein. All rights reserved.
//

#import "MenuViewController.h"
#import "CategoriesViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGetCategories:(id)sender
{
    CategoriesViewController* categoriesViewController = [[CategoriesViewController alloc] initWithStyle:UITableViewStylePlain andCategoryID:[NSNumber numberWithInt:-1] andTitle:@"Root"];
    [self.navigationController pushViewController:categoriesViewController animated:YES];

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
