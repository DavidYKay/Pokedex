//
//  PDDetailViewController.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "FliteTTS.h"
#import "Pokedex.h"

#import "PDDetailViewController.h"

#import "Pokemon.h"

@interface PDDetailViewController ()

    @property (strong, nonatomic) UIPopoverController *masterPopoverController;
    - (void)configureView;

@end

@implementation PDDetailViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
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

#pragma mark - UI Callbacks

- (IBAction)helloWasPressed:(id)sender {
    [self sayHello];
}

#pragma mark - Speech Synthesis

- (void)sayHello {

    FliteTTS * fliteEngine = [Pokedex sharedInstance].fliteEngine;
    [fliteEngine setVoice:@"cmu_us_awb"];                 // Switch to a different voice

    [fliteEngine speakText:@"How are you gentlemen???"];                 // Make it talk
    //[fliteEngine setPitch:100.0 variance:50.0 speed:1.0]; // Change the voice properties
    
    //[fliteEngine stopTalking];                            // stop talking
}


#pragma mark - Managing the detail item

- (void)setPokemon:(id)newPokemon
{
    if (_pokemon != newPokemon) {
	_pokemon = newPokemon;

	// Update the view.
	[self configureView];
    }

    if (self.masterPopoverController != nil) {
	[self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.pokemon) {
        self.detailDescriptionLabel.text = self.pokemon.name;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



@end
