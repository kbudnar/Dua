//
//  DuaDetailViewController.m
//  Dua
//
//  Created by Khalid Ahmed on 9/11/12.
//  Copyright (c) 2012 Khalid Ahmed. All rights reserved.
//

#import "DuaDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SHK.h"


@interface DuaDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DuaDetailViewController

#pragma mark - Managing the detail item
@synthesize shareBtn = _shareBtn;
@synthesize sourceLabel = _sourceLabel;
@synthesize duaText = _duaText;
@synthesize shadowView = _shadowView;
@synthesize duaTitle = _duaTitle;
//@synthesize detailItem = _detailItem;
@synthesize detailsDataSource=_detailDataSource,detailIndex=_detailIndex,mvc=_mvc;

- (void)setDetailItem:(id) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (_detailItem) {
     //NSLog(@"KHALID DUA: %@",[_detailItem objectForKey:@"dua"]);
        _duaTitle.text=[_detailItem objectForKey:@"title"];
        _duaText.text=[_detailItem objectForKey:@"dua"];
        
        _sourceLabel.text=[_detailItem objectForKey:@"source"];
        _shareBtn.enabled=YES;
    }else{
        _shareBtn.enabled=NO;
    }
}



- (void)viewDidLoad
{
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
    CALayer* shadowLayer = [self createShadowWithFrame:CGRectMake(0, 0, 768, 5)];
    
    [_shadowView.layer addSublayer:shadowLayer];
    
    [self.view addSubview:_shadowView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetectedLeft:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetectedRight:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightGesture];
    

}

- (void)viewDidUnload
{
    [self setSourceLabel:nil];
    [self setDuaText:nil];
    [self setShareBtn:nil];
    [self setShadowView:nil];
    [self setDuaTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"الدُّعَاءُ", @"الدُّعَاءُ");
    //self.title=[_detailItem objectForKey:@"title"];
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)share:(id)sender {
   
//    // Create the item to share (in this example, a url)
    NSString *text= [NSString stringWithFormat:@"%@,  دليل: %@",self.duaText.text, self.sourceLabel.text];
    
   SHKItem *item = [SHKItem text:text];
    item.tags = [NSArray arrayWithObjects:@"Dua", @"Sunnah", nil];
//		// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
      [SHK setRootViewController:self];
    [actionSheet showFromBarButtonItem:_shareBtn animated:YES];
	// Display the action sheet
    //[actionSheet showFromToolbar:self.toolbar];
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

//-(void) selectRow{
//    NSIndexPath *path = [NSIndexPath indexPathForRow:_detailIndex inSection:0];
//    [_mvc.tableView
//     selectRowAtIndexPath:path
//     animated:TRUE
//     scrollPosition:UITableViewScrollPositionNone
//     ];
//}
- (void)swipeDetectedRight:(UISwipeGestureRecognizer *)sender
{
    //Access previous cell in TableView
    NSLog(@"Swipe Right");
    if (_detailIndex != 0) // This way it will not go negative
        _detailIndex--;
    
    //[self selectRow];
    [self setDetailItem:[_detailDataSource objectAtIndex:_detailIndex]];
    [self configureView];
}

- (void)swipeDetectedLeft:(UISwipeGestureRecognizer *)sender
{
    //Access next cell in TableView
    NSLog(@"Swipe left");
    if (_detailIndex != [_detailDataSource count]-1) // make sure that it does not go over the number of objects in the array.
        _detailIndex++;
    // [self selectRow];
    [self setDetailItem:[_detailDataSource objectAtIndex:_detailIndex]];
    [self configureView];

}
@end
