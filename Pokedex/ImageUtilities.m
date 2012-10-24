//
//  ImageUtilities.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/23/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "ImageUtilities.h"

#import "StringUtilities.h"

@implementation ImageUtilities

+ (UIImage *)imageForNumber:(NSInteger)number {
    return [UIImage imageNamed: [StringUtilities imageNameForNumber: number]];
}

@end
