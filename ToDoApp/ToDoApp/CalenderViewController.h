//
//  CalenderViewController.h
//  ToDoApp
//
//  Created by Anilkumar on 23/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderViewController : UIViewController
- (IBAction)Done:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *onDateChange;

@end
