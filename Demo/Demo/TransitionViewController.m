#import "TransitionViewController.h"
#import "Constants.h"

#define kImageHeight		200.0
#define kImageWidth			250.0
#define kTransitionDuration	0.75
#define kTopPlacement		10.0	// y coord for the images


@interface TransitionsViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *mainView;
@property (nonatomic, strong) UIImageView *flipToView;

@end


#pragma mark -

@implementation TransitionsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"TransitionsTitle", @"");

	// create the container view which we will use for transition animation (centered horizontally)
	CGRect frame = CGRectMake((CGRectGetWidth(self.view.bounds) - kImageWidth) / 2.0, kTopPlacement, kImageWidth, kImageHeight);
    frame = CGRectIntegral(frame);
    
	self.containerView = [[UIView alloc] initWithFrame:frame];
	[self.view addSubview:self.containerView];
	self.containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
	// the container view can represent the images for accessibility
	[self.containerView setIsAccessibilityElement:YES];
	[self.containerView setAccessibilityLabel:NSLocalizedString(@"ImagesTitle", @"")];
	
	// create the initial image view
	frame = CGRectMake(0.0, 0.0, kImageWidth, kImageHeight);
	self.mainView = [[UIImageView alloc] initWithFrame:frame];
	self.mainView.image = [UIImage imageNamed:@"scene1.jpg"];
    [self.containerView addSubview:self.mainView];
	
	// create the alternate image view (to transition between), we don't add it as a subview yet
	CGRect imageFrame = CGRectMake(0.0, 0.0, kImageWidth, kImageHeight);
	self.flipToView = [[UIImageView alloc] initWithFrame:imageFrame];
	self.flipToView.image = [UIImage imageNamed:@"scene2.jpg"];
}

- (IBAction)curlAction:(id)sender
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kTransitionDuration];
	
	[UIView setAnimationTransition:([self.mainView superview] ?
									UIViewAnimationTransitionCurlUp : UIViewAnimationTransitionCurlDown)
						   forView:self.containerView cache:YES];
	if ([self.flipToView superview])
	{
		[self.flipToView removeFromSuperview];
		[self.containerView addSubview:self.mainView];
	}
	else
	{
		[self.mainView removeFromSuperview];
		[self.containerView addSubview:self.flipToView];
	}
	
	[UIView commitAnimations];
}

- (IBAction)flipAction:(id)sender
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kTransitionDuration];
		
	[UIView setAnimationTransition:([self.mainView superview] ?
										UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
										forView:self.containerView cache:YES];
	if ([self.flipToView superview])
	{
		[self.flipToView removeFromSuperview];
		[self.containerView addSubview:self.mainView];
	}
	else
	{
		[self.mainView removeFromSuperview];
		[self.containerView addSubview:self.flipToView];
	}
	
	[UIView commitAnimations];
}


#pragma mark - UIViewController delegate methods

// called after this controller's view will appear
- (void)viewWillAppear:(BOOL)animated
{	
	[super viewWillAppear:animated];
    
    // for aesthetic reasons (the background is black), make the nav bar black for this particular page
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

@end

