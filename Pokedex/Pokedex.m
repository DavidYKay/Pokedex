#import <FMDatabase.h>


#import "Pokedex.h"

@interface Pokedex ()

@property (readwrite, strong, nonatomic) FMDatabase *database;

@end

@implementation Pokedex

#pragma mark - Initialization

@synthesize database = _database;

- (id) init {
    if (self = [super init]) {
        NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"pokemon" ofType:@"sqlite"];

        FMDatabase *db = [FMDatabase databaseWithPath: databasePath];
	[db open];
        self.database = db;
    }
    return self;
}

#pragma mark - Singleton

static Pokedex *gPokedex = nil;

+ (Pokedex *)sharedInstance {
    if (!gPokedex) {
        gPokedex = [[Pokedex alloc] init];
    }

    return gPokedex;
}

@end
