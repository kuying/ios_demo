
#import "SegmentViewController.h"
#import "Constants.h"

#import <CoreText/CoreText.h>

#define kSegmentedControlHeight 40.0
#define kLabelHeight 20.0

@interface SegmentViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation SegmentViewController

// reusable method to generate a UILabel to title each segmented control
+ (UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
	label.textAlignment = NSTextAlignmentLeft;
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textColor = [UIColor colorWithRed:76.0/255.0 green:86.0/255.0 blue:108.0/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
	label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    return label;
}

// user tapped one of the segmented controls
- (void)segmentAction:(id)sender
{
	//NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
}

- (void)createControls
{
	NSArray *segmentTextContent = @[@"Check", @"Search", @"Tools"];
	
	// label
	CGFloat yPlacement = kTopMargin;
	CGRect frame = CGRectMake(kLeftMargin, yPlacement, CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0), kLabelHeight);
	[self.scrollView addSubview:[SegmentViewController labelWithFrame:frame title:@"UISegmentedControl:"]];
	
#pragma mark - UISegmentedControl
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
												@[
													[UIImage imageNamed:@"segment_check.png"],
													[UIImage imageNamed:@"segment_search.png"],
													[UIImage imageNamed:@"segment_tools.png"]
                                                 ]];
	yPlacement += kTweenMargin + kLabelHeight;
	frame = CGRectMake(	kLeftMargin,
						yPlacement,
						CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
						kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
	segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
	[self.scrollView addSubview:segmentedControl];
	
	// add the appropriate accessibility label to each image
	[[segmentedControl imageForSegmentAtIndex:0] setAccessibilityLabel:NSLocalizedString(@"CheckMarkIcon", @"")];
	[[segmentedControl imageForSegmentAtIndex:1] setAccessibilityLabel:NSLocalizedString(@"SearchIcon", @"")];
	[[segmentedControl imageForSegmentAtIndex:2] setAccessibilityLabel:NSLocalizedString(@"ToolsIcon", @"")];

	// label
	yPlacement += (kTweenMargin * 2.0) + kSegmentedControlHeight;
	frame = CGRectMake(	kLeftMargin,
						yPlacement,
						CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
						kLabelHeight);
	[self.scrollView addSubview:[SegmentViewController labelWithFrame:frame title:@"UISegmentControlStyleBordered:"]];
	
#pragma mark - UISegmentControlStyleBordered
	segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	yPlacement += kTweenMargin + kLabelHeight;
	frame = CGRectMake(	kLeftMargin,
						yPlacement,
						CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
						kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
	segmentedControl.selectedSegmentIndex = 1;
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
	[self.scrollView addSubview:segmentedControl];

	// label
	yPlacement += (kTweenMargin * 2.0) + kSegmentedControlHeight;
	frame = CGRectMake(	kLeftMargin,
					   yPlacement,
					   CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
					   kLabelHeight);
	[self.scrollView addSubview:[SegmentViewController labelWithFrame:frame title:@"UISegmentControlStyleBar:"]];
	
#pragma mark - UISegmentControlStyleBar
	yPlacement += kTweenMargin + kLabelHeight;
	segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	frame = CGRectMake(	kLeftMargin,
					   yPlacement,
					   CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
					   kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 1;
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
	[self.scrollView addSubview:segmentedControl];
	
	// label
	yPlacement += (kTweenMargin * 2.0) + kSegmentedControlHeight;
	frame = CGRectMake(	kLeftMargin,
						yPlacement,
						CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
						kLabelHeight);
	[self.scrollView addSubview:[SegmentViewController labelWithFrame:frame title:@"UISegmentControlStyleBar: tint"]];
		
#pragma mark - UISegmentedControl (red-tinted)
	segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	yPlacement += kTweenMargin + kLabelHeight;
	frame = CGRectMake(	kLeftMargin,
						yPlacement,
						CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
						kSegmentedControlHeight);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;	
	segmentedControl.tintColor = [UIColor colorWithRed:0.70 green:0.171 blue:0.1 alpha:1.0];
	segmentedControl.selectedSegmentIndex = 1;
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
	[self.scrollView addSubview:segmentedControl];
    
#pragma mark - UISegmentedControl (image background)
    yPlacement += (kTweenMargin * 2.0) + kSegmentedControlHeight;
    frame = CGRectMake(	kLeftMargin,
                       yPlacement,
                       CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
                       kLabelHeight);
    [self.scrollView addSubview:[SegmentViewController labelWithFrame:frame
                                                          title:@"UISegmentControlStyleBar: image"]];

    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    yPlacement += kTweenMargin + kLabelHeight;
    frame = CGRectMake(kLeftMargin,
                       yPlacement,
                       CGRectGetWidth(self.view.bounds) - (kRightMargin * 2.0),
                       kSegmentedControlHeight);
    segmentedControl.frame = frame;
    [segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;	
    segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"segmentedBackground"]
                                                     forState:UIControlStateNormal
                                                  barMetrics:UIBarMetricsDefault];
    
    [segmentedControl setDividerImage:[UIImage imageNamed:@"divider"]
                  forLeftSegmentState:UIControlStateNormal
                    rightSegmentState:UIControlStateNormal
                           barMetrics:UIBarMetricsDefault];
    
    // we want attributed strings for this segmented control
    NSDictionary *textAttributes = @{ UITextAttributeTextColor:[UIColor blueColor],
                                      UITextAttributeFont:[UIFont systemFontOfSize:13.0] };
    [segmentedControl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    textAttributes = @{ UITextAttributeTextColor:[UIColor redColor],
                        UITextAttributeFont:[UIFont systemFontOfSize:13.0] };
    [segmentedControl setTitleTextAttributes:textAttributes forState:UIControlStateHighlighted];
    
    [self.scrollView addSubview:segmentedControl];
}


#pragma mark -

- (void)viewDidLoad
{	
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"SegmentTitle", @"");

    // set the content size of our scroll view to match the entire screen,
    // this will allow the content to scroll in landscape
    //
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame),
                                               CGRectGetHeight(self.scrollView.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame))];
    
    [self createControls];	// create the showcase of segment controls
}

@end

