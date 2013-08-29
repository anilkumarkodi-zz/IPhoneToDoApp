//
//  TaskRow.h
//  ToDoApp
//
//  Created by Anilkumar on 26/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskRow : NSObject{
    NSNumber *todoId;
    NSString *todoTitle;
    NSString *status;
    NSString *date;
}

@property(nonatomic,retain) NSString *todoTitle;
@property(nonatomic,retain) NSString *date;
@property NSNumber *todoId;
@property (nonatomic,retain)  NSString *status;

@end
