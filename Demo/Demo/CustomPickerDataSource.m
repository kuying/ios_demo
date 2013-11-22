#import "CustomPickerDataSource.h"
#import "CustomView.h"

@implementation CustomPickerDataSource

@synthesize customPickerArray;

- (id)init
{
	// use predetermined frame size
	self = [super init];
	if (self)
	{
		// create the data source for this custom picker
		NSMutableArray *viewArray = [[NSMutableArray alloc] init];

        CustomView *earlyMorningView = [[CustomView alloc] initWithTitle:@"Early Morning"
                                                                   image:[UIImage imageNamed:@"12-6AM.png"]];
		[viewArray addObject:earlyMorningView];

		CustomView *lateMorningView = [[CustomView alloc] initWithTitle:@"Late Morning"
                                                                   image:[UIImage imageNamed:@"6-12AM.png"]];
		[viewArray addObject:lateMorningView];

		CustomView *afternoonView = [[CustomView alloc] initWithTitle:@"Afternoon"
                                                                  image:[UIImage imageNamed:@"12-6PM.png"]];
		[viewArray addObject:afternoonView];

		CustomView *eveningView = [[CustomView alloc] initWithTitle:@"Evening"
                                                              image:[UIImage imageNamed:@"6-12PM.png"]];
		[viewArray addObject:eveningView];

		self.customPickerArray = viewArray;
	}
	return self;
}


#pragma mark - UIPickerViewDataSource

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return [CustomView viewWidth];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return [CustomView viewHeight];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [customPickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


#pragma mark - UIPickerViewDelegate

// tell the picker which view to use for a given component and row, we have an array of views to show
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
	return [customPickerArray objectAtIndex:row];
}

@end
