//
//  PokemonTableCell.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/27/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;

@end
