//
//  SubTaskController.h
//  ToDoApp
//
//  Created by Anilkumar on 26/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskRow.h"
#import "TaskDataModel.h"

@interface SubTaskController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    TaskRow *taskrow;
    TaskDataModel *taskmodel;
    NSMutableArray *tableData;
}
- (IBAction)onBack:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
- (IBAction)addSubtask:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

