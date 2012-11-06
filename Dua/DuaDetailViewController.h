//
//  DuaDetailViewController.h
//  Dua
//
//  Created by Khalid Ahmed on 9/11/12.
//  Copyright (c) 2012 Khalid Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DuaMasterViewController.h"

@interface DuaDetailViewController : UIViewController <UISplitViewControllerDelegate>

- (IBAction)share:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareBtn;

@property (nonatomic, strong) PFObject *detailItem;
@property (weak, nonatomic) IBOutlet UITextView *sourceLabel;
@property (weak, nonatomic) IBOutlet UITextView *duaText;
@property (strong, nonatomic) IBOutlet UIView *shadowView;

@property (strong, nonatomic) IBOutlet UILabel *duaTitle;

@property (strong, nonatomic) NSArray *detailsDataSource;
@property int detailIndex;
@property (nonatomic, retain) DuaMasterViewController *mvc;
@end
