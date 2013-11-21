#import "PeriodicElements.h"
#import "AtomicElement.h"

@implementation PeriodicElements

// we use the singleton approach, one collection for the entire application
static PeriodicElements *sharedPeriodicElementsInstance = nil;

+ (PeriodicElements *)sharedPeriodicElements {
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedPeriodicElementsInstance = [[self alloc] init]; });
    }
    return sharedPeriodicElementsInstance;
}
 
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedPeriodicElementsInstance == nil) {
            sharedPeriodicElementsInstance = [super allocWithZone:zone];
            return sharedPeriodicElementsInstance;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// setup the data collection
- init {
	if (self = [super init]) {
		[self setupElementsArray];
	}
	return self;
}

- (void)setupElementsArray {
    
	NSDictionary *eachElement;
	
	// create dictionaries that contain the arrays of element data indexed by
	// name
	self.elementsDictionary = [NSMutableDictionary dictionary];
	// physical state
	self.statesDictionary = [NSMutableDictionary dictionary];
	// unique first characters (for the Name index table)
	self.nameIndexesDictionary = [NSMutableDictionary dictionary];

	// create empty array entries in the states Dictionary or each physical state
	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Solid"];
	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Liquid"];
	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Gas"];
	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Artificial"];
	
	// read the element data from the plist
	NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Elements" ofType:@"plist"];
	NSArray *rawElementsArray = [[NSArray alloc] initWithContentsOfFile:thePath];

	// iterate over the values in the raw elements dictionary
	for (eachElement in rawElementsArray)
	{
		// create an atomic element instance for each
		AtomicElement *anElement = [[AtomicElement alloc] initWithDictionary:eachElement];
		
		// store that item in the elements dictionary with the name as the key
		[self.elementsDictionary setObject:anElement forKey:anElement.name];
		
		// add that element to the appropriate array in the physical state dictionary 
		[[self.statesDictionary objectForKey:anElement.state] addObject:anElement];
		
		// get the element's initial letter
		NSString *firstLetter = [anElement.name substringToIndex:1];
		NSMutableArray *existingArray = [self.nameIndexesDictionary valueForKey:firstLetter];
        
		// if an array already exists in the name index dictionary
		// simply add the element to it, otherwise create an array
		// and add it to the name index dictionary with the letter as the key
        //
		if (existingArray != nil)
		{
            [existingArray addObject:anElement];
		} else {
			NSMutableArray *tempArray = [NSMutableArray array];
			[self.nameIndexesDictionary setObject:tempArray forKey:firstLetter];
			[tempArray addObject:anElement];
		}
	}
	
	// create the dictionary containing the possible element states
	// and presort the states data
	self.elementPhysicalStatesArray = [NSArray arrayWithObjects:@"Solid", @"Liquid", @"Gas", @"Artificial", nil];
	[self presortElementsByPhysicalState];
	
	// presort the dictionaries now
	// this could be done the first time they are requested instead
	//
	[self presortElementInitialLetterIndexes];
	
	self.elementsSortedByNumber = [self presortElementsByNumber];
	self.elementsSortedBySymbol = [self presortElementsBySymbol];
}

// return the array of elements for the requested physical state
- (NSArray *)elementsWithPhysicalState:(NSString *)aState {
    
	return [self.statesDictionary objectForKey:aState];
}

// presort each of the arrays for the physical states
- (void)presortElementsByPhysicalState {
    
	for (NSString *stateKey in self.elementPhysicalStatesArray) {
		[self presortElementsWithPhysicalState:stateKey];
	}
}

- (void)presortElementsWithPhysicalState:(NSString *)state {
    
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
																   ascending:YES
																	selector:@selector(localizedCaseInsensitiveCompare:)] ;
	
	NSArray *descriptors = [NSArray arrayWithObject:nameDescriptor];
	[[self.statesDictionary objectForKey:state] sortUsingDescriptors:descriptors];
}

// return an array of elements for an initial letter (ie A, B, C, ...)
- (NSArray *)elementsWithInitialLetter:(NSString*)aKey {
    
	return [self.nameIndexesDictionary objectForKey:aKey];
}

// presort the name index arrays so the elements are in the correct order
- (void)presortElementInitialLetterIndexes {
    
	self.elementNameIndexArray = [[self.nameIndexesDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	for (NSString *eachNameIndex in self.elementNameIndexArray) {
		[self presortElementNamesForInitialLetter:eachNameIndex];
	}
}

- (void)presortElementNamesForInitialLetter:(NSString *)aKey {
    
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
																   ascending:YES
																	selector:@selector(localizedCaseInsensitiveCompare:)] ;
	
	NSArray *descriptors = [NSArray arrayWithObject:nameDescriptor];
	[[self.nameIndexesDictionary objectForKey:aKey] sortUsingDescriptors:descriptors];
}

// presort the elementsSortedByNumber array
- (NSArray *)presortElementsByNumber {
    
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"atomicNumber"
																   ascending:YES
																	selector:@selector(compare:)] ;
	
	NSArray *descriptors = [NSArray arrayWithObject:nameDescriptor];
	NSArray *sortedElements = [[self.elementsDictionary allValues] sortedArrayUsingDescriptors:descriptors];
	return sortedElements;
}

// presort the elementsSortedBySymbol array
- (NSArray *)presortElementsBySymbol {
    
	NSSortDescriptor *symbolDescriptor = [[NSSortDescriptor alloc] initWithKey:@"symbol"
																   ascending:YES
																	selector:@selector(localizedCaseInsensitiveCompare:)] ;
	
	NSArray *descriptors = [NSArray arrayWithObject:symbolDescriptor];
	NSArray *sortedElements = [[self.elementsDictionary allValues] sortedArrayUsingDescriptors:descriptors];
	return sortedElements;
}

@end