#import "AtomicElementView.h"
#import "AtomicElement.h"
#import "AtomicElementFlippedView.h"

@interface AtomicElementFlippedView ()

@property (nonatomic,strong) UIButton *wikipediaButton;

@end

@implementation AtomicElementFlippedView


- (void)setupUserInterface {
    
	CGRect buttonFrame = CGRectMake(10.0, 209.0, 234.0, 37.0);
	
    // create the button
	self.wikipediaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.wikipediaButton.frame=buttonFrame;
	
	[self.wikipediaButton setTitle:@"View at Wikipedia" forState:UIControlStateNormal];	
	
	// Center the text on the button, considering the button's shadow
	self.wikipediaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	self.wikipediaButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	
	[self.wikipediaButton addTarget:self action:@selector(jumpToWikipedia:) forControlEvents:UIControlEventTouchUpInside];

	[self addSubview:self.wikipediaButton];
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
		[self setAutoresizesSubviews:YES];
		[self setupUserInterface];
		
		// set the background color of the view to clearn
		self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)jumpToWikipedia:(id)sender {
    
	// create the string that points to the correct Wikipedia page for the element name
	NSString *wikiPageString = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.element.name];
	if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:wikiPageString]])
	{
		// there was an error trying to open the URL. for the moment we'll simply ignore it.
	}
}

- (void)drawRect:(CGRect)rect {
	
	// get the background image for the state of the element
	// position it appropriately and draw the image
    //
	UIImage *backgroundImage = [self.element stateImageForAtomicElementView];
	CGRect elementSymbolRectangle = CGRectMake(0, 0, [backgroundImage size].width, [backgroundImage size].height);
	[backgroundImage drawInRect:elementSymbolRectangle];
	
	// all the text is drawn in white
	[[UIColor whiteColor] set];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIFont boldSystemFontOfSize:32], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, nil]];
	
	// draw the element number
	CGPoint point = CGPointMake(10,5);
	[[NSString stringWithFormat:@"%@", self.element.atomicNumber] drawAtPoint:point withAttributes:dict];
	
	// draw the element symbol
	CGSize stringSize = [self.element.symbol sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width-10),5);
	[self.element.symbol drawAtPoint:point withAttributes:dict];
	
	// draw the element name
    dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIFont boldSystemFontOfSize:36], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, nil]];
	stringSize = [self.element.name sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2,50);
	[self.element.name drawAtPoint:point withAttributes:dict];
	
	float verticalStartingPoint = 95;
	
	// draw the element weight
    dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIFont boldSystemFontOfSize:14], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, nil]];
	NSString *atomicWeightString = [NSString stringWithFormat:@"Atomic Weight: %@", self.element.atomicWeight];
	stringSize = [atomicWeightString sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint);
	[atomicWeightString drawAtPoint:point withAttributes:dict];
	
	// draw the element state
	NSString *stateString=[NSString stringWithFormat:@"State: %@", self.element.state];
	stringSize = [stateString sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+20);
	[stateString drawAtPoint:point withAttributes:dict];
	
	// draw the element period
	NSString *periodString = [NSString stringWithFormat:@"Period: %@", self.element.period];
	stringSize = [periodString sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+40);
	[periodString drawAtPoint:point withAttributes:dict];

	// draw the element group
	NSString *groupString = [NSString stringWithFormat:@"Group: %@", self.element.group];
	stringSize = [groupString sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+60);
	[groupString drawAtPoint:point withAttributes:dict];
	
	// draw the discovery year
	NSString *discoveryYearString = [NSString stringWithFormat:@"Discovered: %@", self.element.discoveryYear];
	stringSize = [discoveryYearString sizeWithAttributes:dict];
	point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+80);
	[discoveryYearString drawAtPoint:point withAttributes:dict];
}


@end
