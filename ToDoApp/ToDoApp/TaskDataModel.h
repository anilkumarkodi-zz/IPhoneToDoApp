//
//  taskData.h
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskRow.h"
@interface TaskDataModel : NSObject{
    TaskRow *row;
    int dbResultCode;
}
    
-(void)inserttitle:(NSString*)title anddate:(NSString*)date;
-(NSMutableArray*)getData:(NSMutableArray*) array;
-(TaskRow*)getMaxRecord:(TaskRow*) row ;
-(void) deleteRow:(NSNumber*)todoId;
    
@end
