#import "CustomView.h"

@interface CustomView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CustomView

const CGFloat kViewWidth = 200;
const CGFloat kViewHeight = 44;
const CGFloat kLabelHeight = 20;
const CGFloat kMarginSize = 10;

+ (CGFloat)viewWidth
{
    return kViewWidth;
}

+ (CGFloat)viewHeight 
{
    return kViewHeight;
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, kViewWidth, kViewHeight)];
	if (self)
	{
		CGFloat yCoord = (self.bounds.size.height - kLabelHeight) / 2;
        
        _titleLabel = [[UILabel alloc] initWithFrame:
                                    CGRectMake( kMarginSize + image.size.width + kMarginSize,
                                                yCoord,
                                                CGRectGetWidth(self.frame) - kMarginSize + image.size.width + kMarginSize,
                                                kLabelHeight)];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
        yCoord = (self.bounds.size.height - image.size.height) / 2;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(kMarginSize,
                                               yCoord,
                                               image.size.width,
                                               image.size.height)];
        imageView.image = image;
        [self addSubview:imageView];
	}
	return self;
}

// Enable accessibility for this view.
- (BOOL)isAccessibilityElement
{
	return YES;
}

// Return a string that describes this view.
- (NSString *)accessibilityLabel
{
	return self.titleLabel.text;
}

@end
