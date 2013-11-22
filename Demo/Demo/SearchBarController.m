#import "SearchBarController.h"

@interface SearchBarController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) IBOutlet UISegmentedControl *contentOptions;

@end


#pragma mark -

@implementation SearchBarController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"SearchBarTitle", @"");
    
	self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 44.0)];
	self.mySearchBar.delegate = self;
	self.mySearchBar.showsCancelButton = YES;
    self.mySearchBar.showsBookmarkButton = YES;
    
	[self.view addSubview: self.mySearchBar];
    self.mySearchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (IBAction)contentChoice:(id)sender
{
    self.mySearchBar.tintColor = nil;
    self.mySearchBar.backgroundImage = nil;
    [self.mySearchBar setImage:nil
              forSearchBarIcon:UISearchBarIconBookmark
                         state:UIControlStateNormal];
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
    {
        case 1:
        {
            // tinted background
            self.mySearchBar.tintColor = [UIColor blueColor];
            break;
        }
            
        case 2:
        {
            // image background
            self.mySearchBar.backgroundImage = [UIImage imageNamed:@"searchBarBackground"];
            [self.mySearchBar setImage:[UIImage imageNamed:@"bookmarkImage"]
                      forSearchBarIcon:UISearchBarIconBookmark
                                 state:UIControlStateNormal];
            [self.mySearchBar setImage:[UIImage imageNamed:@"bookmarkImageHighlighted"]
                      forSearchBarIcon:UISearchBarIconBookmark
                                 state:UIControlStateHighlighted];
            break;
        }
    }
}


#pragma mark - UISearchBarDelegate

// called when the bookmark button inside the search bar is tapped
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{

}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.mySearchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[self.mySearchBar resignFirstResponder];
}

@end
