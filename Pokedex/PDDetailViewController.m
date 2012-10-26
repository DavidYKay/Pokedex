//
//  PDDetailViewController.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "FliteTTS.h"

#import "FISoundEngine.h"
#import "FIFactory.h"
#import "FISound.h"

#import "VSSpeechSynthesizer.h"

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

        _soundFactory = [[FIFactory alloc] init];
        _soundEngine = [_soundFactory buildSoundEngine];
        [_soundEngine activateAudioSessionWithCategory:AVAudioSessionCategoryPlayback];
        [_soundEngine openAudioDevice];

        //NSURL *soundEffectUrl = [[NSBundle mainBundle] URLForResource:@"testSound" withExtension:@"wav"];
        NSURL *soundEffectUrl = [[NSBundle mainBundle] URLForResource:@"Name-001" withExtension:@"caf"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundEffectUrl), &_soundEffect);
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

- (IBAction)speakWasPressed:(id)sender {
    [self sayHello];
}

- (IBAction)finchWasPressed:(id)sender {
    [self playPokemonName];
}

- (IBAction)testSoundWasPressed:(id)sender {
    [self playMySoundLikeRightNowReally];
}

- (IBAction)avAudioWasPressed:(id)sender {
    [self avPlaySound];
}

- (IBAction)privateApiWasPressed:(id)sender {
    [self privateApiHello];
}

#pragma mark - Sound Playback

- (void)playPokemonName {
    NSLog(@"playPokemonName");
    NSError *error = nil;
    //FISound *soundA = [_soundFactory loadSoundNamed: @"testSound.wav"
    FISound *soundA = [_soundFactory loadSoundNamed: @"Name-001.caf"
                                              error: &error];
    if (error) {
        NSLog(@"ERROR! Could not load sound. Reason: %@", error);
    } else {
        //FISound *soundB = [soundFactory loadSoundNamed:@"gun.wav" maxPolyphony:4 error:NULL];
        [soundA play];
    }
}

- (void)playMySoundLikeRightNowReally {
    NSLog(@"playMySoundLikeRightNowReally");

    AudioServicesPlaySystemSound(_soundEffect);
}

- (void)avPlaySound {
    _avSound = [SoundUtilities getNameSoundForNumber: 2];

    [_avSound play];
}

#pragma mark - Private Speech Synthesis

- (void)privateApiHello {
    NSLog(@"privateApiHello");

    //id speechSynthesizer =[NSClassFromString(@"VSSpeechSynthesizer") new];
    VSSpeechSynthesizer *speech = [[NSClassFromString(@"VSSpeechSynthesizer") alloc] init];
    //startSpeakingString:@"hello world"]; (@"VSSpeechSynthesizer") new];

    //[speech performSelector: @selector(startSpeakingString:) withObject: @"hello world"];

    [speech setRate:(float) 1.0];
    [speech startSpeakingString:@"Hello world, how are you"];

    //startSpeakingString:@"hello world"];

}

#pragma mark - Speech Synthesis

- (void)sayHello {
    NSLog(@"sayHello");

    FliteTTS * fliteEngine = [Pokedex sharedInstance].fliteEngine;
    [fliteEngine setVoice: @"cmu_us_rms"];                 // Switch to a different voice

    //[fliteEngine speakText:@"How are you gentlemen???"];                 // Make it talk

    [fliteEngine speakText: self.pokemon.biography];                 // Make it talk

    // voices
    // cmu_us_kal - very robotic. slightly slavic sounding. not quite like zugg.
    // cmu_us_kal16 - smoother/more human than kal. sounds neurotic/depressed.
    // cmu_us_awb - vague irish tone. whimsical-sounding.
    // cmu_us_rms - very neutral voice. reminiscent of the MS Sam voice.
    // cmu_us_slt - female voice. not bad. slightly awkward.

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
        self.pokemonImage.image = [ImageUtilities imageForNumber: self.pokemon.number];

        self.numberLabel.text = [StringUtilities numberLabelFromNumber: self.pokemon.number];

        self.nameLabel.text = self.pokemon.name;
        self.bioLabel.text = self.pokemon.biography;
        self.primaryTypeLabel.text = self.pokemon.primaryType;
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
   AudioServicesDisposeSystemSoundID(_soundEffect);

   //[super dealloc];
}

@end
