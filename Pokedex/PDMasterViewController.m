//
//  PDMasterViewController.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <FMDatabase.h>

#import "PDMasterViewController.h"

#import "Pokemon.h"
#import "Pokedex.h"
#import "PDDetailViewController.h"
#import "StringUtilities.h"
#import "ImageUtilities.h"

#import "PokemonTableCell.h"

@interface PDMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PDMasterViewController

@synthesize monsters = _monsters;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Pokémon";
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 72;
    self.searchController.searchResultsTableView.rowHeight = 72;

    //self.navigationController.navigationBarHidden = YES;

    //Add the search bar
    self.tableView.tableHeaderView = self.tableHeaderBar;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;

    //[self refresh: PDPokemonSortModeNumber];
    [self refresh];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
	interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
    ) {
	return YES;
    }
    return NO;
}

#pragma mark - UI Callbacks

- (IBAction)pokemonModeWasToggled:(id)sender {

    if (sender == self.pokemonSortModeControl) {
	UISegmentedControl *toggle = (UISegmentedControl *)sender;

	if (toggle.selectedSegmentIndex == 0) {
	    NSLog(@"NUMBER mode selected");

	    self.pokemonSortMode = PDPokemonSortModeNumber;
	    [self refresh];
	} else if (toggle.selectedSegmentIndex == 1) {
	    NSLog(@"NAME mode selected");

	    self.pokemonSortMode = PDPokemonSortModeName;
	    [self refresh];
	}
    }
}

#pragma mark - Data Management

- (void)refresh {
    [self refresh: self.pokemonSortMode];
}

- (void)refresh:(PDPokemonSortMode)mode {
    NSString *selectString = @"* from pokemon";

    NSString *sortString;
    if (mode == PDPokemonSortModeNumber) {
	sortString = @"number ASC";
    } else if (mode == PDPokemonSortModeName) {
	sortString = @"name ASC";
    } else {
	sortString = @"number ASC";
    }

    NSString *queryString = [NSString stringWithFormat: @"SELECT %@ ORDER BY %@", selectString, sortString];

    FMDatabase *database = [Pokedex sharedInstance].database;
    FMResultSet *results = [database executeQuery: queryString];

    NSMutableArray *monsters = [NSMutableArray array];
    while ([results next]) {
        NSInteger number           = [results intForColumn:@"number"];
        NSString *name             = [results stringForColumn:@"name"];
        NSString *primaryType      = [results stringForColumn:@"primary_type"];
        NSString *secondaryType    = [results stringForColumn:@"secondary_type"];
        NSString *biography        = [results stringForColumn:@"biography"];
        NSString *primaryAbility   = [results stringForColumn:@"primary_ability"];
        NSString *secondaryAbility = [results stringForColumn:@"secondary_ability"];

        Pokemon *pokemon = [[Pokemon alloc] init];
        pokemon.number           = number;
        pokemon.name             = name;
        pokemon.primaryType      = primaryType;
        pokemon.secondaryType    = secondaryType;
        pokemon.biography        = biography;
        pokemon.primaryAbility   = primaryAbility;
        pokemon.secondaryAbility = secondaryAbility;

        [monsters addObject: pokemon];
    }

    self.monsters = monsters;
}

#pragma mark - Search Bar

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    NSLog(@"searchBarTextDidBeginEditing");

    _searching = YES;
    _letUserSelectRow = NO;
    //self.tableView.scrollEnabled = NO;

    //Add the done button.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self action:@selector(doneSearchingWasClicked:)];
}

#pragma mark - Search Display

- (void)filterContentForSearchText:(NSString *)searchText
                             scope:(NSString *)scope
{
    NSLog(@"filterContentForSearchText: %@", searchText);

    NSPredicate *resultPredicate = [NSPredicate
	predicateWithFormat:@"name contains[cd] %@", searchText];
	//predicateWithFormat:@"SELF.name contains[cd] %@", searchText];
    //publisher == %@", @"Apress" ];

    self.searchResults = [self.monsters filteredArrayUsingPredicate: resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
    shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"filterContentForSearchText: %@", searchString);

    [self filterContentForSearchText: searchString
                               scope: [[self.searchController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchController.searchBar
                                                     selectedScopeButtonIndex]]];

    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText: [self.searchController.searchBar text]
                               scope: [[self.searchController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];

    return YES;
}


//- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //if (theTableView == self.tableView) {
	//return indexPath;
    //} else {
	//if(_letUserSelectRow) {
	    //return indexPath;
	//} else {
	    //return nil;
	//}
    //}
//}

#pragma mark - Accessor / Mutator

- (void)setMonsters:(NSArray *)monsters {
    NSArray *oldMonsters = _monsters;
    _monsters = monsters;

    if (monsters.count > 0 && self.detailViewController && oldMonsters.count == 0) {
	self.detailViewController.pokemon = [monsters objectAtIndex: 0];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: segment these by pokemon generation
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.monsters.count;
    } else if (tableView == self.searchController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        return 0;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    PokemonTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PokemonTableCell" owner:self options:nil];
        cell = [views objectAtIndex: 0];
    }

    [self configureCell: cell
	    inTableView: tableView
	    atIndexPath: indexPath];

    return cell;
}

- (void)configureCell:(PokemonTableCell *)cell inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    Pokemon *pokemon = [self getPokemonFromTable: tableView atIndexPath: indexPath];

    cell.nameLabel.text         = pokemon.name;
    cell.numberLabel.text       = [StringUtilities numberLabelFromNumber: pokemon.number];
    cell.pokemonImageView.image = [ImageUtilities imageForNumber: pokemon.number];

}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row);

    Pokemon *pokemon = [self getPokemonFromTable: tableView atIndexPath: indexPath];

    self.detailViewController.pokemon = pokemon;
}

#pragma mark - Utility

- (Pokemon *)getPokemonFromTable:(UITableView *)tableView
		     atIndexPath:(NSIndexPath *)indexPath
{
    Pokemon *pokemon = nil;
    if (tableView == self.tableView) {
	pokemon = [self.monsters objectAtIndex: indexPath.row];
    } else if (tableView == self.searchController.searchResultsTableView) {
	pokemon = [self.searchResults objectAtIndex: indexPath.row];
    }
    return pokemon;
}

@end
