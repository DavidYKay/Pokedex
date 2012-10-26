//
//  SoundUtilities.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/26/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundUtilities : NSObject

+ (AVAudioPlayer *)getNameSoundForNumber:(NSInteger)pokemonNumber;

@end
