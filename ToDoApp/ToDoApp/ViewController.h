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
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *completedButton;

@property (weak, nonatomic) IBOutlet UITextField *enterTaskTextField;
-(NSString *)get:(int)index;
- (IBAction)setEditing:(BOOL)editing animated:(BOOL)animate;
- (IBAction)deleteActionButton:(id)index;
@end
