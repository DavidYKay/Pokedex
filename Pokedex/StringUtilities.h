//
//  StringUtilities.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/23/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtilities : NSObject

+ (NSString *)imageNameForNumber:(NSInteger)number;

+ (NSString *)numberLabelFromNumber:(NSInteger)number;
+ (NSString *)zeroLeadingNumber:(NSInteger)number;

@end
