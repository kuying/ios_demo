#import <UIKit/UIKit.h>
#import "ElementsDataSourceProtocol.h"

@interface ElementsTableViewController : UITableViewController

@property (nonatomic,strong) id<ElementsDataSource, UITableViewDataSource> dataSource;

@end
