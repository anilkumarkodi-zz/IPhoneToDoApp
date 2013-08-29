//
//  CompletedViewController.m
//  ToDoApp
//
//  Created by Anilkumar on 28/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "CompletedViewController.h"
#import "TableCell.h"
#import "SubTaskController.h"
@interface CompletedViewController ()

@end

@implementation CompletedViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataModel= [TaskDataModel alloc];
    dataModel = [dataModel initWithDbProperties];
    tableData = [[NSMutableArray alloc] init];
    tableData = [dataModel getData:tableData forStatus:@"COMPLETED"];
    [tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableCell";
    TableCell *cell = (TableCell*)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.4];
    TaskRow *row = (TaskRow*)[tableData objectAtIndex:indexPath.row];
    [cell.dateLabelCell setTextColor:[UIColor grayColor]];
    [cell.titleLabelCell setTextColor:[UIColor grayColor]];
    cell.dateLabelCell.text = row.date;
    cell.titleLabelCell.text = row.todoTitle;
    return cell;
}
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        TaskDataModel *taskData = [[TaskDataModel alloc] initWithDbProperties];
        TaskRow *row = [tableData objectAtIndex:indexPath.row];
        [tableData removeObjectAtIndex:indexPath.row];
        [taskData deleteRow:row.todoId];
        [tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
