//
//  CompletedViewController.m
//  ToDoApp
//
//  Created by Anilkumar on 28/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "CompletedListViewController.h"
#import "TableCell.h"
#import "SubTaskController.h"
@interface CompletedListViewController ()

@end

@implementation CompletedListViewController
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
    tableData = [dataModel getCompletedTask:tableData];
    [tableView reloadData];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"werwerw");
    SubTaskController *subTaskController=[[SubTaskController alloc] init];
    [self.navigationController pushViewController:subTaskController animated:YES];
    TableCell *t = (TableCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    subTaskController.titleLabel.text = t.titleLabelCell.text;
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
