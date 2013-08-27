//
//  ViewController.h
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"


@interface ViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>{
    TaskData *task ;
    UINavigationBar * navBar;
    UIView * contentView;
    NSString *actualDate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, retain) IBOutlet  NSString *actualDate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *completedButton;
@property (weak, nonatomic) IBOutlet UITextField *enterTaskTextField;

- (IBAction)loadCalender:(id)sender;
- (void) setDate:(NSNotification*) notification;
@end
