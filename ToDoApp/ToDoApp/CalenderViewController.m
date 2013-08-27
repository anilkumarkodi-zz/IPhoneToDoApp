//
//  CalenderViewController.m
//  ToDoApp
//
//  Created by Anilkumar on 23/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "CalenderViewController.h"
#import "ViewController.h"

@interface CalenderViewController ()

@end

@implementation CalenderViewController
@synthesize datePicker;
@synthesize finalDate;
@synthesize dateLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect pickerFrame = CGRectMake(20,200,50,50);
    UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [myPicker addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:myPicker];
    NSDate* eventDate=[NSDate date];
    
    NSString *date = [NSDateFormatter localizedStringFromDate:eventDate
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
     finalDate = date;
    dateLabel.text=date;
}

- (IBAction)Done:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedDate" object:finalDate];

}

- (void)pickerChanged:(id)sender
{
    NSString *date = [NSDateFormatter localizedStringFromDate:[sender date]
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
    finalDate = date;
    dateLabel.text = date;
}

@end



