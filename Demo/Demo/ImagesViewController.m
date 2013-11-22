#import "ImagesViewController.h"
#import "Constants.h"

#define kMinDuration 0.0
#define kMaxDuration 10.0

@interface ImagesViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UISlider *slider;

@end


#pragma mark -

@implementation ImagesViewController

- (void)viewDidLoad
{	
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"ImagesTitle", @"");
	
	// set up our UIImage with a group or array of images to animate (or in our case a slideshow)
	self.imageView.animationImages = @[
										[UIImage imageNamed:@"scene1.jpg"],
										[UIImage imageNamed:@"scene2.jpg"],
										[UIImage imageNamed:@"scene3.jpg"],
										[UIImage imageNamed:@"scene4.jpg"],
										[UIImage imageNamed:@"scene5.jpg"]
									  ];
	self.imageView.animationDuration = 5.0;
	[self.imageView stopAnimating];
	
	// Set the appropriate accessibility labels.
	[self.imageView setIsAccessibilityElement:YES];
	[self.imageView setAccessibilityLabel:self.title];
	[self.slider setAccessibilityLabel:NSLocalizedString(@"DurationSlider", @"")];
}

// slown down or speed up the slide show as the slider is moved
- (IBAction)sliderAction:(id)sender
{
	UISlider *durationSlider = sender;
	self.imageView.animationDuration = [durationSlider value];
	if (!self.imageView.isAnimating)
		[self.imageView startAnimating];
}


#pragma mark - UIViewController delegate methods

// called after this controller's view was dismissed, covered or otherwise hidden
- (void)viewWillDisappear:(BOOL)animated
{	
	[super viewWillDisappear:animated];
    
    [self.imageView stopAnimating];
}

// called after this controller's view will appear
- (void)viewWillAppear:(BOOL)animated
{	
	[super viewWillAppear:animated];
    
    [self.imageView startAnimating];
	
	// for aesthetic reasons (the background is black), make the nav bar black for this particular page
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

@end

