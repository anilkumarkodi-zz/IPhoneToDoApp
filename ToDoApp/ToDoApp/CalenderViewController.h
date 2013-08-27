//
//  CalenderViewController.h
//  ToDoApp
//
//  Created by Anilkumar on 23/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderViewController : UIViewController{
    NSString *finalDate;
}

- (IBAction)Done:(id)sender;
@property (nonatomic, retain) NSString *finalDate;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
