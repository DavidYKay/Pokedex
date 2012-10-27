//
//  PDMasterViewController.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDDetailViewController;

#import <CoreData/CoreData.h>

@interface PDMasterViewController : UITableViewController {

    BOOL _searching;
    BOOL _letUserSelectRow;

}

@property (strong, nonatomic) PDDetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *monsters;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
