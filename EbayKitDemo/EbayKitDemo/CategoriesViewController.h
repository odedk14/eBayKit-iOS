//
//  CategoriesViewController.h
//  EbayKitDemo
//
//  Created by Oded Klein on 8/17/14.
//  Copyright (c) 2014 Oded Klein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UITableViewController

@property (nonatomic) NSInteger categoryID;

- (id)initWithStyle:(UITableViewStyle)style andCategoryID:(NSNumber*)aCategoryID andTitle:(NSString*)aTitle;

@end
