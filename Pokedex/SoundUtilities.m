//
//  SoundUtilities.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/26/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "SoundUtilities.h"

#import "StringUtilities.h"

@implementation SoundUtilities

+ (AVAudioPlayer *)getBioSoundForNumber:(NSInteger)pokemonNumber {
    NSURL *soundURL = [SoundUtilities getBioSoundURLForNumber: pokemonNumber];
    return [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
}


+ (AVAudioPlayer *)getNameSoundForNumber:(NSInteger)pokemonNumber {
    NSURL *soundURL = [SoundUtilities getNameSoundURLForNumber: pokemonNumber];
    return [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
}

+ (NSURL *)getBioSoundURLForNumber:(NSInteger)pokemonNumber {
    NSString *bioString = [NSString stringWithFormat: @"Bio-%@", [StringUtilities zeroLeadingNumber: pokemonNumber]];
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:bioString
                                              withExtension:@"caf"];

    return soundURL;
}

+ (NSURL *)getNameSoundURLForNumber:(NSInteger)pokemonNumber {
    NSString *nameString = [NSString stringWithFormat: @"Name-%@", [StringUtilities zeroLeadingNumber: pokemonNumber]];
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:nameString
                                              withExtension:@"caf"];

    return soundURL;
}

@end
