
#import "AtomicElementTileView.h"
#import "AtomicElement.h"

@implementation AtomicElementTileView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
		_element = nil;
    }
    return self;
}
 
- (void)drawRect:(CGRect)rect {
    
	CGPoint point;
    
	// get the image that represents the element physical state and draw it
	UIImage *backgroundImage = self.element.stateImageForAtomicElementTileView;
	CGRect elementSymbolRectangle = CGRectMake(0,0, [backgroundImage size].width, [backgroundImage size].height);
	[backgroundImage drawInRect:elementSymbolRectangle];
	
	[[UIColor whiteColor] set];
	
	// draw the element number
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIFont boldSystemFontOfSize:11], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, nil]];

	point = CGPointMake(3,2);
	[[self.element.atomicNumber stringValue] drawAtPoint:point withAttributes:dict];
	
	// draw the element symbol
    dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIFont boldSystemFontOfSize:18], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, nil]];
	CGSize stringSize = [self.element.symbol sizeWithAttributes:dict];
	point = CGPointMake((elementSymbolRectangle.size.width-stringSize.width)/2, 14.0);
	
	[self.element.symbol drawAtPoint:point withAttributes:dict];
}

@end
