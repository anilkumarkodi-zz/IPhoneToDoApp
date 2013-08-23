//
//  ViewController.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "ViewController.h"
#import "TaskData.h"
#import "CalenderViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *tableData;
@synthesize enterTaskTextField;
@synthesize tableView;

- (void)viewDidLoad
{
    [enterTaskTextField setDelegate:self];  
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)setEditing:(BOOL)editing animated:(BOOL)animate {
    [super setEditing:editing animated:animate];
    [self.tableView setEditing:editing animated:animate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableData removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
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
-(IBAction)loadCalender:(id)sender{
      CalenderViewController *cvc = [[CalenderViewController alloc] init];
     [self presentViewController:cvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CompletedTask:(id)sender {
    NSLog(@"value: %@",[sender date]);
}
@end
