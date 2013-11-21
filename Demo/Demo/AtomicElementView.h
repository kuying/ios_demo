#import <UIKit/UIKit.h>

@class AtomicElement;
@class AtomicElementViewController;

@interface AtomicElementView : UIView

@property (nonatomic,strong) AtomicElement *element;
@property (nonatomic, weak) AtomicElementViewController *viewController;

+ (CGSize)preferredViewSize;
- (UIImage *)reflectedImageRepresentationWithHeight:(NSUInteger)height;

@end
