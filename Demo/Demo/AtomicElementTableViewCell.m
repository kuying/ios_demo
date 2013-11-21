#import "AtomicElementTableViewCell.h"
#import "AtomicElement.h"
#import "AtomicElementTileView.h"

@implementation AtomicElementTableViewCell

- (void)setElement:(AtomicElement *)anElement {
    
    if (anElement != _element) {
		_element = anElement;
	}
	
    AtomicElementTileView *elementTileView = (AtomicElementTileView *)[self.contentView viewWithTag:1];
    elementTileView.element = _element;
    
	UILabel *labelView = (UILabel *)[self.contentView viewWithTag:2];
    labelView.text = _element.name;
    
	[elementTileView setNeedsDisplay];
	[labelView setNeedsDisplay];
}

@end
