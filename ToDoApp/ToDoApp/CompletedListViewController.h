//
//  CompletedViewController.h
//  ToDoApp
//
//  Created by Anilkumar on 28/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDataModel.h"

@interface CompletedListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *tableData;
    TaskDataModel *dataModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)popViewController:(id)sender;

@end
