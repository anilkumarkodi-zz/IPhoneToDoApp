//
//  TableCell.h
//  ToDoApp
//
//  Created by Anilkumar on 26/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *dateLabelCell;

@end
