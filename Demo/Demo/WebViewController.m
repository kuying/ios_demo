#import "WebViewController.h"
#import "Constants.h"

@interface WebViewController () <UITextFieldDelegate, UIWebViewDelegate>
@property (nonatomic, strong) UIWebView	*myWebView;
@end


#pragma mark -

@implementation WebViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"WebTitle", @"");

	// create the URL input field
    CGRect textFieldFrame = CGRectMake(kLeftMargin, kTweenMargin,
									   CGRectGetWidth(self.view.bounds) - (kLeftMargin * 2.0), kTextFieldHeight);
	UITextField *urlField = [[UITextField alloc] initWithFrame:textFieldFrame];
    urlField.borderStyle = UITextBorderStyleBezel;
    urlField.textColor = [UIColor blackColor];
    urlField.delegate = self;
    urlField.placeholder = @"<enter a full URL>";
    urlField.text = @"http://www.apple.com";
	urlField.backgroundColor = [UIColor whiteColor];
	urlField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	urlField.returnKeyType = UIReturnKeyGo;
	urlField.keyboardType = UIKeyboardTypeURL;	// this makes the keyboard more friendly for typing URLs
	urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;	// don't capitalize
	urlField.autocorrectionType = UITextAutocorrectionTypeNo;	// we don't like autocompletion while typing
	urlField.clearButtonMode = UITextFieldViewModeAlways;
	[urlField setAccessibilityLabel:NSLocalizedString(@"URLTextField", @"")];
	[self.view addSubview:urlField];
    
    // create the UIWebView
    CGRect webFrame = self.view.frame;
    webFrame.origin.y += (kTweenMargin * 2.0) + kTextFieldHeight;	// leave room for the URL input field
	webFrame.size.height -= 40.0;
    self.myWebView = [[UIWebView alloc] initWithFrame:webFrame];
    
	self.myWebView.backgroundColor = [UIColor whiteColor];
	self.myWebView.scalesPageToFit = YES;
	self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin);
	self.myWebView.delegate = self;
	[self.view addSubview:self.myWebView];
	
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]]];
}


#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    self.myWebView.delegate = self;	// setup the delegate as the web view is shown
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.myWebView stopLoading];	// in case the web view is still loading its content
	self.myWebView.delegate = nil;	// disconnect the delegate as the webview is hidden
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// this helps dismiss the keyboard when the "Done" button is clicked
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[textField text]]]];
	
	return YES;
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	// report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
							 @"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\"><html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'><title></title></head><body><div style='width: 100%%; text-align: center; font-size: 36pt; color: red;'>An error occurred:<br>%@</div></body></html>", error.localizedDescription];
	[self.myWebView loadHTMLString:errorString baseURL:nil];
}

@end