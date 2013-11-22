#import "TextViewController.h"

@interface TextViewController () <UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@end


#pragma mark -

@implementation TextViewController

- (void)setupTextView
{
	_textView = [[UITextView alloc] initWithFrame:self.view.frame];
	self.textView.textColor = [UIColor blackColor];
	self.textView.font = [UIFont fontWithName:@"Arial" size:18.0];
	self.textView.delegate = self;
	self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	NSString *textToAdd = @"Now is the time for all good developers to come to serve their country.\n\nNow is the time for all good developers to come to serve their country.\r\rThis text view can also use attributed strings.";
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textToAdd];

    // make red text
    [attrString addAttribute:NSForegroundColorAttributeName
                   value:[UIColor redColor]
                   range:NSMakeRange([attrString length] - 19, 19)];
    
    // make blue text
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:NSMakeRange([attrString length] - 23, 3)];
    [attrString addAttribute:NSUnderlineStyleAttributeName
                       value:[NSNumber numberWithInteger:1]
                       range:NSMakeRange([attrString length] - 23, 3)];
    
    [self.textView setAttributedText:attrString];
    
	self.textView.returnKeyType = UIReturnKeyDefault;
	self.textView.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	self.textView.scrollEnabled = YES;

	// note: for UITextView, if you don't like auto correction while typing use:
	// myTextView.autocorrectionType = UITextAutocorrectionTypeNo;
	
	[self.view addSubview:self.textView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"TextViewTitle", @"");
	[self setupTextView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
    // listen for keyboard hide/show notifications so we can properly adjust the table's height
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


#pragma mark - Notifications

- (void)adjustViewForKeyboardReveal:(BOOL)showKeyboard notificationInfo:(NSDictionary *)notificationInfo
{
    // the keyboard is showing so resize the table's height
	CGRect keyboardRect = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration =
    [[notificationInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.textView.frame;
    
    // the keyboard rect's width and height are reversed in landscape
    NSInteger adjustDelta =
        UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? CGRectGetHeight(keyboardRect) : CGRectGetWidth(keyboardRect);
    
    if (showKeyboard)
        frame.size.height -= adjustDelta;
    else
        frame.size.height += adjustDelta;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.textView.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
	[self adjustViewForKeyboardReveal:YES notificationInfo:[aNotification userInfo]];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self adjustViewForKeyboardReveal:NO notificationInfo:[aNotification userInfo]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - UITextViewDelegate

- (void)saveAction:(id)sender
{
	// finish typing text/dismiss the keyboard by removing it as the first responder
	//
	[self.textView resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;	// this will remove the "save" button
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	// provide my own Save button to dismiss the keyboard
	UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
															target:self
															action:@selector(saveAction:)];
	self.navigationItem.rightBarButtonItem = saveItem;
}

@end

