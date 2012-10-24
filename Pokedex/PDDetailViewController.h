//
//  PDDetailViewController.h
//  Pokedex
//
//  Created by David Young-Chan Kay on 10/22/12.
//  Copyright (c) 2012 David Y. Kay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pokemon;

@interface PDDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Pokemon *pokemon;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@property (weak, nonatomic) IBOutlet UILabel *primaryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;

- (IBAction)helloWasPressed:(id)sender;

@end
