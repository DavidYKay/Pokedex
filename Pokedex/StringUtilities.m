//
//  StringUtilities.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/23/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "StringUtilities.h"

@implementation StringUtilities

#pragma mark - Utility

+ (NSString *)imageNameForNumber:(NSInteger)number {
    return [NSString stringWithFormat: @"%03d.png", number];
}

+ (NSString *)numberLabelFromNumber:(NSInteger)number {
    return [NSString stringWithFormat: @"#%@", [StringUtilities zeroLeadingNumber: number]];
}

+ (NSString *)zeroLeadingNumber:(NSInteger)number {
    return [NSString stringWithFormat: @"%03d", number];
}


@end
