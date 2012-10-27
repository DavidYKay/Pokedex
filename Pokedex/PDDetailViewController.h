//
//  PDDetailViewController.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import <AudioToolbox/AudioToolbox.h>

@class Pokemon;
@class FIFactory;
@class FISoundEngine;

@interface PDDetailViewController : UIViewController <UISplitViewControllerDelegate> {

     SystemSoundID _soundEffect;
     FIFactory *_soundFactory;
     FISoundEngine *_soundEngine;

     AVAudioPlayer *_nameSound;
     AVAudioPlayer *_bioSound;

}

@property (strong, nonatomic) Pokemon *pokemon;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@property (weak, nonatomic) IBOutlet UILabel *primaryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;

- (IBAction)speakWasPressed:(id)sender;
- (IBAction)finchWasPressed:(id)sender;
- (IBAction)privateApiWasPressed:(id)sender;
- (IBAction)avAudioWasPressed:(id)sender;
- (IBAction)testSoundWasPressed:(id)sender;

@end
