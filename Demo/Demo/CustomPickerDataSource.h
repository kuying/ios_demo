
@interface CustomPickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
	NSArray	*customPickerArray;
}

@property (nonatomic, retain) NSArray *customPickerArray;

@end
