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

@interface PDMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PDMasterViewController

@synthesize monsters = _monsters;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    [self refresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Data Management

- (void)refresh {
    FMDatabase *database = [Pokedex sharedInstance].database;
    FMResultSet *results = [database executeQuery: @"SELECT * from pokemon"];

    NSMutableArray *monsters = [NSMutableArray array];
    while ([results next]) {
        NSInteger number        = [results intForColumn:@"number"];
        NSString *name          = [results stringForColumn:@"name"];
        NSString *primaryType   = [results stringForColumn:@"primary_type"];
        NSString *secondaryType = [results stringForColumn:@"secondary_type"];
        NSString *biography     = [results stringForColumn:@"biography"];

        Pokemon *pokemon = [[Pokemon alloc] init];
        pokemon.number        = number;
        pokemon.name          = name;
        pokemon.primaryType   = primaryType;
        pokemon.secondaryType = secondaryType;
        pokemon.biography     = biography;

        [monsters addObject: pokemon];
    }

    self.monsters = monsters;
}

#pragma mark - Utility

- (NSString *)imageNameForNumber:(NSInteger)number {
    return [NSString stringWithFormat: @"%03d.png", number];
}

- (NSString *)numberLabelFromNumber:(NSInteger)number {
    return [NSString stringWithFormat: @"#%03d", number];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: segment these by pokemon generation
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.monsters.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Pokemon *pokemon = [self.monsters objectAtIndex: indexPath.row];

    cell.textLabel.text = pokemon.name;
    cell.detailTextLabel.text = [self numberLabelFromNumber: pokemon.number];
    cell.imageView.image = [UIImage imageNamed: [self imageNameForNumber: pokemon.number]];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//    self.detailViewController.detailItem = object;
}

@end
