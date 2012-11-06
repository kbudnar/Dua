//
//  DuaAppDelegate.h
//  Dua
//
//  Created by Khalid Ahmed on 9/11/12.
//  Copyright (c) 2012 Khalid Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)customizeiPadTheme;

-(void)customizeiPhoneTheme;

-(void)iPadInit;

//-(void)configureiPhoneTabBar;
//
//-(void)configureTabBarItemWithImageName:(NSString*)imageName andText:(NSString *)itemText forViewController:(UIViewController *)viewController;

@end
