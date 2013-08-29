//
//  SubTaskController.m
//  ToDoApp
//
//  Created by Anilkumar on 26/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "SubTaskController.h"
#import "TaskDataModel.h"
#import "TableCell.h"

@interface SubTaskController ()

@end

@implementation SubTaskController
@synthesize titleLabel;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    taskrow = [[TaskRow alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getMainTask:)
                                                 name:@"sendTaskObject" object:nil];
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(setCompleted:)];
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [tableView addGestureRecognizer:gesture]; 
}

-(void) setCompleted:(UISwipeGestureRecognizer*) recognizer{
    CGPoint swipeLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    UITableViewCell *swipedCell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    TableCell *swipedCell1 = (TableCell*)swipedCell;
    [swipedCell1.textLabel setTextColor:[UIColor darkGrayColor]];
    TaskDataModel *tablemodel = [[TaskDataModel alloc] initWithDbProperties];
    TaskRow *row = [tableData objectAtIndex:swipedIndexPath.row];
    
    [tablemodel updateStatusForSubtask:row.todoId];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"TableCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.4];
    TaskRow *row = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = row.todoTitle;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    if([row.status isEqual: @"COMPLETED"]){
        [cell.textLabel setTextColor:[UIColor grayColor]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
       TaskDataModel *taskData = [[TaskDataModel alloc] initWithDbProperties];
        TaskRow *row = [tableData objectAtIndex:indexPath.row];
        [tableData removeObjectAtIndex:indexPath.row];
        [taskData deleteSubTaskRow:row.todoId];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
        [tableData insertObject:@"Tutorial" atIndex:[tableData count]];
        [tableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

-(void)getMainTask:(NSNotification*)notification{
    taskrow =(TaskRow*) [notification object];
    titleLabel.numberOfLines = 3;
    titleLabel.text = taskrow.todoTitle;
    titleLabel.textColor=[UIColor whiteColor];
    tableData = [[NSMutableArray alloc]init];
    taskmodel = [[TaskDataModel alloc]initWithDbProperties];
    tableData = [taskmodel getSubtask:tableData forTaskId:[taskrow.todoId integerValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addSubtask:(id)sender {
    CGRect frame = CGRectMake(50, 170, 230, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:17.0];
    textField.placeholder = @"add subtask and press enter";
    textField.backgroundColor = [UIColor clearColor];
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    [self.view addSubview:textField];
        [tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TaskDataModel *taskDataModel = [[TaskDataModel alloc] initWithDbProperties];
    [taskDataModel addSubtask:textField.text taskid:[taskrow.todoId integerValue]];
    [textField resignFirstResponder];
    textField.text = nil;
    tableData = [[NSMutableArray alloc]init];
    taskmodel = [[TaskDataModel alloc]initWithDbProperties];
    tableData = [taskmodel getSubtask:tableData forTaskId:[taskrow.todoId integerValue]];
    [textField setHidden:YES];
    [tableView reloadData];
    return YES;
}
@end
