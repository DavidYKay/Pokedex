#import <UIKit/UIKit.h>

@class FMDatabase;
@class FliteTTS;

@interface Pokedex : NSObject

@property (readonly, strong, nonatomic) FMDatabase *database;
@property (readonly, strong, nonatomic) FliteTTS *fliteEngine;

+ (Pokedex *)sharedInstance;

@end
