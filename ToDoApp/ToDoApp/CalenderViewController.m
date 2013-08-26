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
@synthesize datePicked;
@synthesize onDateChange;


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

    //calender with time
    CGRect pickerFrame = CGRectMake(20,200,50,50);

    UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    [myPicker addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:myPicker];
    
  //Calender with out time
     //    UIDatePicker *theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, 320.0, 216.0)];
     //    theDatePicker.datePickerMode = UIDatePickerModeDate;
     //    self.datePicker = theDatePicker;
     //    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
     //    [self.view addSubview:datePicker];
    
//    
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
//                                     initWithTitle:NSLocalizedString(@"Cancel", @"Cancel - for button to cancel changes")
//                                     style:UIBarButtonItemStylePlain
//                                     target:self
//                                     action:@selector(cancel)];
//    self.navigationItem.leftBarButtonItem = cancelButton;
//
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:NSLocalizedString(@"Save", @"Save - for button to save changes")
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(save)];
//    self.navigationItem.rightBarButtonItem = saveButton;
//        
    
    
    
    
 }
-(NSString* )getDate{
    return datePicked;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Done:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pickerChanged:(id)sender
{
    NSString *date = [NSDateFormatter localizedStringFromDate:[sender date]
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
    datePicked = date;
    onDateChange.text = date;
}
@end



