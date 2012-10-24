#import <UIKit/UIKit.h>

@class FMDatabase;

@interface Pokedex : NSObject

@property (readonly, strong, nonatomic) FMDatabase *database;

+ (Pokedex *)sharedInstance;

@end
