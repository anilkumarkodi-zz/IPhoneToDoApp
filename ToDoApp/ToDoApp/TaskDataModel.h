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
-(NSMutableArray*)getData:(NSMutableArray*) array;
-(NSMutableArray*)getCompletedTask:(NSMutableArray*) array;

-(TaskRow*)getMaxRecord:(TaskRow*) row ;
-(void) deleteRow:(NSNumber*)todoId;
-(void) updateStatus:(NSNumber*)todoId;
-(id)initWithDbProperties;
    
@end
