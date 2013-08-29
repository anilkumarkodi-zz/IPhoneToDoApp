//
//  taskData.h
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskRow.h"
#import <sqlite3.h>

@interface TaskDataModel : NSObject{
    TaskRow *row;
    sqlite3 *db;
    sqlite3_stmt *dbps;
    int dbResultCode;
}

-(void)inserttitle:(NSString*)title anddate:(NSString*)date;
-(void)addSubtask:(NSString*)title taskid:(NSInteger)taskId;
-(NSMutableArray*)getData:(NSMutableArray*) array forStatus:(NSString*) status;
-(NSMutableArray*)getSubtask:(NSMutableArray*) array forTaskId:(NSInteger)taskId;
-(TaskRow*)getMaxRecord:(TaskRow*) row ;
-(void) deleteRow:(NSNumber*)todoId;
-(void)deleteSubTaskRow:(NSNumber *)subTaskId;
-(void) updateStatus:(NSNumber*)todoId;
-(void) updateStatusForSubtask:(NSNumber*)todoId;
-(id)initWithDbProperties;
    
@end
