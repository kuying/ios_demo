#import <Foundation/Foundation.h>

@interface PeriodicElements : NSObject

@property (nonatomic, strong) NSMutableDictionary *statesDictionary;
@property (nonatomic, strong) NSMutableDictionary *elementsDictionary;
@property (nonatomic, strong) NSMutableDictionary *nameIndexesDictionary;
@property (nonatomic, strong) NSArray *elementNameIndexArray;
@property (nonatomic, strong) NSArray *elementsSortedByNumber;
@property (nonatomic, strong) NSArray *elementsSortedBySymbol;
@property (nonatomic, strong) NSArray *elementPhysicalStatesArray;

+ (PeriodicElements*)sharedPeriodicElements;

- (NSArray *)elementsWithPhysicalState:(NSString*)aState;
- (NSArray *)elementsWithInitialLetter:(NSString*)aKey;

@end
