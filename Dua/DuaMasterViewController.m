//
//  DuaMasterViewController.m
//  dua
//
//  Created by Khalid Ahmed on 9/11/12.
//  Copyright (c) 2012 Khalid Ahmed. All rights reserved.
//


#import "DuaMasterViewController.h"

#import "DuaDetailViewController.h"
#import "MasterCell.h"

@implementation DuaMasterViewController
//@synthesize iphoneDetailViewController = _iphoneDetailViewController;
@synthesize masterTableView=_masterTableView, delegate=_delegate;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-menubar-left.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
     _masterTableView.delegate = self;
    //masterTableView.dataSource = self;
    
    CALayer * shadow = [self createShadowWithFrame:CGRectMake(0, 0, 320, 5)];
    [self.view.layer addSublayer:shadow];
    
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
    self.detailViewController = (DuaDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    
    [super viewDidLoad];
    }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(CALayer *)createShadowWithFrame:(CGRect)frame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    
    
    UIColor* lightColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UIColor* darkColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    gradient.colors = [NSArray arrayWithObjects:(id)darkColor.CGColor, (id)lightColor.CGColor, nil];
    
    return gradient;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait
                || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ;
    } else {
        return YES;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        [[segue destinationViewController] setDetailsDataSource:self.objects];
        [[segue destinationViewController] setDetailIndex:indexPath.row];
       
    }
}

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"createdAt"];
    
    return query;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      // for ipad
      if(indexPath.row < [self.objects count]){
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        self.detailViewController.detailItem = object;
         self.detailViewController.detailsDataSource=self.objects;
          self.detailViewController.detailIndex=indexPath.row;

      }else{
          [self loadNextPage];
      }
 }else{
     // for iphone 
     if(indexPath.row >= [self.objects count]){// if load more is selected
        [self loadNextPage];
     }
 }
}




- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    //PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    MasterCell *cell = (MasterCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.titleLabel.text = [object objectForKey:@"title"];
    cell.textLabel.text = [object objectForKey:@"source"];
    
    //cell.textLabel.text = duaTitle;
    
   
    
    if(indexPath.row == [self.objects count])
    {
        CALayer* shadow = [self createShadowWithFrame:CGRectMake(0, 67, 320, 5)];
        
        [cell.layer addSublayer:shadow];
    }
    
    if(indexPath.row == 0)
    {
        [tableView
         selectRowAtIndexPath:indexPath
         animated:TRUE
         scrollPosition:UITableViewScrollPositionNone
         ];
        
        [[tableView delegate]
         tableView:tableView
         didSelectRowAtIndexPath:indexPath
         ];
        
    }

    return cell;

}




@end
