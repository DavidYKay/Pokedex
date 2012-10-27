//
//  PDDetailViewController.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "PDDetailViewController.h"

#import "ImageUtilities.h"
#import "Pokedex.h"
#import "Pokemon.h"
#import "StringUtilities.h"
#import "SoundUtilities.h"

#pragma mark - Private Methods

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


- (IBAction)avAudioWasPressed:(id)sender {
    [self sayPokemonName];
}

#pragma mark - Sound Playback

- (void)stopSound {
    if (_nameSound.isPlaying) {
        [_nameSound stop];
    }
    if (_bioSound.isPlaying) {
        [_bioSound stop];
    }
}

- (void)sayPokemonName {
    if (_pokemon) {
        AVAudioPlayer *newSound = [SoundUtilities getNameSoundForNumber: _pokemon.number];
        if (![newSound.url isEqual: _nameSound.url]) {
            _nameSound = newSound;
            [_nameSound play];
        }
    }
}

- (void)sayPokemonBio {
    if (_pokemon) {
        AVAudioPlayer *newSound = [SoundUtilities getBioSoundForNumber: _pokemon.number];
        if (![newSound.url isEqual: _bioSound.url]) {
            _bioSound = newSound;
            [_bioSound play];
        }
    }
}

#pragma mark - Failed Sound Attempts

- (void)playMySoundLikeRightNowReally {
    NSLog(@"playMySoundLikeRightNowReally");

}

#pragma mark - Speech Synthesis

#pragma mark - Managing the detail item

- (void)setPokemon:(id)newPokemon
{
    if (_pokemon != newPokemon) {
        _pokemon = newPokemon;

        [self stopSound];

        // Update the view.
        [self configureView];

        [self sayPokemonName];
        [self performSelector:@selector(sayPokemonBio) withObject:nil afterDelay: 1.5];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.pokemon) {
        self.pokemonImage.image = [ImageUtilities imageForNumber: self.pokemon.number];

        self.numberLabel.text = [StringUtilities numberLabelFromNumber: self.pokemon.number];

        self.nameLabel.text          = self.pokemon.name;
        self.bioLabel.text           = self.pokemon.biography;
        self.primaryTypeLabel.text   = self.pokemon.primaryType;
        self.secondaryTypeLabel.text = self.pokemon.secondaryType;
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

#pragma mark - Cleanup

- (void) dealloc {

    //[super dealloc];
}

@end
