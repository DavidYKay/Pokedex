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

typedef enum {
    PDPokemonSortModeNumber = 0,
    PDPokemonSortModeName   = 1,
} PDPokemonSortMode;

@interface PDMasterViewController : UITableViewController <UISearchDisplayDelegate> {

    BOOL _searching;
    BOOL _letUserSelectRow;

    PDPokemonSortMode _pokemonSortMode;
}

@property (strong, nonatomic) PDDetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *monsters;
@property (strong, nonatomic) NSArray *searchResults;

@property PDPokemonSortMode pokemonSortMode;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISearchDisplayController *searchController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pokemonSortModeControl;
@property (weak, nonatomic) IBOutlet UIView *tableHeaderBar;

- (IBAction)pokemonModeWasToggled:(id)sender;

@end
