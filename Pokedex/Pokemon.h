//
//  Pokemon.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/23/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject

@property (nonatomic) NSInteger number;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *primaryType;
@property (strong, nonatomic) NSString *secondaryType;
@property (strong, nonatomic) NSString *biography;
@property (strong, nonatomic) NSString *primaryAbility;
@property (strong, nonatomic) NSString *secondaryAbility;

@end
