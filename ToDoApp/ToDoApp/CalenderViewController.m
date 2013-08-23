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
    CGRect pickerFrame = CGRectMake(0,250,0,0);
    
    UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [myPicker addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:myPicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Done:(id)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)pickerChanged:(id)sender
{
    NSString *d = [NSDateFormatter localizedStringFromDate:[sender date]
                                                                        dateStyle:NSDateFormatterShortStyle
                                                                        timeStyle:NSDateFormatterFullStyle];
    onDateChange.text = d;
//    NSLog(@"value: %@",[sender date]);
}
@end
