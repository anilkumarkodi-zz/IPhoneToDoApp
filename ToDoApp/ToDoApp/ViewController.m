//
//  ViewController.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "ViewController.h"
#import "TaskDataModel.h"
#import "TableCell.h"
#import "TaskRow.h"
#import "CalenderViewController.h"
#import "CompletedListViewController.h"
#import "SubTaskController.h"
@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *tableData;
@synthesize enterTaskTextField;
@synthesize tableView;
@synthesize actualDate;

- (void)viewDidLoad
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setDate:)
                                                 name:@"selectedDate" object:nil];

    [super viewDidLoad];
    taskData = [TaskDataModel alloc];
    taskData = [taskData initWithDbProperties];
    tableData = [[NSMutableArray alloc] init];
    tableData = [taskData getData:tableData];
    actualDate = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                dateStyle:NSDateFormatterShortStyle
                                                timeStyle:NSDateFormatterShortStyle];

    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleSwipeFrom:)];
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [tableView addGestureRecognizer:gesture];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{

    CGPoint swipeLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    UITableViewCell *swipedCell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];

    TableCell *swipedCell1 = (TableCell*)swipedCell;
    [swipedCell1.titleLabelCell setTextColor:[UIColor darkGrayColor]];
    
    TaskRow *row = [tableData objectAtIndex:swipedIndexPath.row];
    taskData = [TaskDataModel alloc];
    taskData = [taskData initWithDbProperties];
    
    [taskData updateStatus:row.todoId];
    [tableData removeObjectAtIndex:swipedIndexPath.row];
    NSIndexPath *indexPath = [[NSIndexPath alloc]init];
    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *a = [[NSArray alloc]initWithObjects:swipedIndexPath, nil];
    NSLog(@"here comming %d",swipedIndexPath.row);

    [tableView deleteRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationBottom];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableCell";
    TableCell *cell = (TableCell*)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.4];
    TaskRow *row = (TaskRow*)[tableData objectAtIndex:indexPath.row];
    cell.dateLabelCell.text = row.date;
    cell.titleLabelCell.text = row.todoTitle;
    return cell;
}
-(void)setDate:(NSNotification*) notification{
     actualDate = [notification object];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle == UITableViewCellEditingStyleDelete){
            taskData = [TaskDataModel alloc];
            taskData = [taskData initWithDbProperties];
            TaskRow *row = [tableData objectAtIndex:indexPath.row];
            [tableData removeObjectAtIndex:indexPath.row];
            [taskData deleteRow:row.todoId];
            [tableView reloadData];
        }
        else if (editingStyle == UITableViewCellEditingStyleInsert){
            [tableData insertObject:@"Tutorial" atIndex:[tableData count]];
            [tableView reloadData];
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    taskData = [TaskDataModel alloc];
    taskData = [taskData initWithDbProperties];
    TaskRow *taskRow=[[TaskRow alloc]init];
    [taskData inserttitle:textField.text anddate:actualDate];
    
    taskData = [TaskDataModel alloc];
    taskData = [taskData initWithDbProperties];
    taskRow = [taskData getMaxRecord:taskRow];
    
    [tableData insertObject:taskRow atIndex:0];
    [tableView reloadData];
    
    [textField resignFirstResponder];
    self.enterTaskTextField.text = nil;
    return YES;
}

- (IBAction)onCompleted:(id)sender {
    CompletedListViewController *completedViewController = [[CompletedListViewController alloc]init];
    [self presentViewController:completedViewController animated:YES completion:nil];
}

-(IBAction)loadCalender:(id)sender
{
    CalenderViewController *cvc = [[CalenderViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    SubTaskController *subTaskController=[[SubTaskController alloc] init];
    [self.navigationController pushViewController:subTaskController animated:YES];
    TableCell *t = (TableCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    subTaskController.titleLabel.text = t.titleLabelCell.text;
}

@end
