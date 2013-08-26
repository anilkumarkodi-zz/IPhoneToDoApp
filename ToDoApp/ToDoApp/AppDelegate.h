//
//  AppDelegate.h
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSString *dbFilePath;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
