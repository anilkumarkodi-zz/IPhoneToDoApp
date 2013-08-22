//
//  taskData.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "TaskData.h"

@implementation TaskData

-(void)initWithArray{
    data[0] = @"one";
    data[1] = @"two";
}
-(NSString *)get:(int)index{
    return data[index];
}
@end
