#import "ElementsTableViewController.h"

#import "AtomicElement.h"
#import "AtomicElementTableViewCell.h"
#import "AtomicElementViewController.h"
#import "DemoAppDelegate.h"
#import "ElementsDataSourceProtocol.h"


@implementation ElementsTableViewController

- (void)setDataSource:(id<ElementsDataSource,UITableViewDataSource>)dataSource {
    
    _dataSource = dataSource;
    
    self.title = [_dataSource name];
    self.tabBarItem.image = [_dataSource tabBarImage];
    self.navigationItem.title = [_dataSource navigationBarName];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.sectionIndexMinimumDisplayRowCount = 10;
    
    self.tableView.delegate = self;
	self.tableView.dataSource = self.dataSource;
    
    // create a custom navigation bar button and set it to always say "back"
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"Back";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
	// force the tableview to load
	[self.tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        // find the right view controller
        AtomicElement *element = [self.dataSource atomicElementForIndexPath:selectedIndexPath];
        AtomicElementViewController *viewController =
            (AtomicElementViewController *)segue.destinationViewController;
        
        // hide the bottom tabbar when we push this view controller
        viewController.hidesBottomBarWhenPushed = YES;
        
        // pass the element to this detail view controller
        viewController.element = element;
    }
}

@end
