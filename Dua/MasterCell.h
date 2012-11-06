//
//  MasterCell.h
//  ocean
//
//  Created by Tope on 27/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MasterCell : PFTableViewCell

@property (nonatomic, strong) IBOutlet UILabel* titleLabel;

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

@property (nonatomic, strong) IBOutlet UIImageView* disclosureImageView;


@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;

@end
