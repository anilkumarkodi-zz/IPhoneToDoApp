//
//  ViewController.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "ViewController.h"
#import "TaskData.h"
#import "TableCell.h"
#import "CalenderViewController.h"
#import "SubTaskController.h"
@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *tableData;
@synthesize enterTaskTextField;
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
}
- (IBAction)setEditing:(BOOL)editing animated:(BOOL)animate {
//    [super setEditing:editing animated:animate];
//    [self.tableView setEditing:editing animated:animate];
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
    cell.dateLabelCell.text = @"12-12-2013";
    cell.titleLabelCell.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle == UITableViewCellEditingStyleDelete){
            [tableData removeObjectAtIndex:indexPath.row];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tableData insertObject:textField.text atIndex:0];
    [tableView reloadData];
    [textField resignFirstResponder];
    self.enterTaskTextField.text = nil;
    return YES;
}

-(IBAction)loadCalender:(id)sender
{
      CalenderViewController *cvc = [[CalenderViewController alloc] init];
     [self.navigationController pushViewController:cvc animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    SubTaskController *subTaskController=[[SubTaskController alloc] init];
    [self.navigationController pushViewController:subTaskController animated:YES];
    subTaskController.title.text = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
