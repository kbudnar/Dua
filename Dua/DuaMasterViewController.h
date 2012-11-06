//
//  DuaMasterViewController.h
//  Dua
//
//  Created by Khalid Ahmed on 9/11/12.
//  Copyright (c) 2012 Khalid Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
@protocol DuaMasterViewControllerDelegate;
@class DuaDetailViewController;


@interface DuaMasterViewController : PFQueryTableViewController<UITableViewDelegate>


@property (strong, nonatomic) DuaDetailViewController *detailViewController;


@property (nonatomic, strong) IBOutlet UITableView* masterTableView;

@property (nonatomic, unsafe_unretained) id<DuaMasterViewControllerDelegate> delegate;

-(CALayer *)createShadowWithFrame:(CGRect)frame;


@end


@protocol DuaMasterViewControllerDelegate <NSObject>


@end