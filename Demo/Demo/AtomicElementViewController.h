#import <UIKit/UIKit.h>

@class AtomicElement;

@interface AtomicElementViewController : UIViewController

@property (nonatomic,strong) AtomicElement *element;

- (void)flipCurrentView;

@end
