//
//  PokemonTableCell.m
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/27/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import "PokemonTableCell.h"

@implementation PokemonTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
