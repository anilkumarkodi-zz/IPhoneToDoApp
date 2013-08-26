//
//  TableViewCell.h
//  ToDoApp
//
//  Created by Anilkumar on 26/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabelInCell;

@property (weak, nonatomic) IBOutlet UILabel *dateInCell;
@end
