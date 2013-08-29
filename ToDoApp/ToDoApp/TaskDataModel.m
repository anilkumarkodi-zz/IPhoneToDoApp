//
//  taskData.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "TaskDataModel.h"
#import "AppDelegate.h"
#import "TaskRow.h"
@implementation TaskDataModel


-(id)initWithDbProperties{
    self=[super init];
    if(self){
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    dbResultCode = sqlite3_open(dbFilePathUTF8,&db);
    }
    return self;
}

-(void)inserttitle:(NSString*)title anddate:(NSString*)date{
    if([self isConnectionAlive:dbResultCode]) return ;
    NSString *insertStatementNS = [NSString stringWithFormat:@"insert into \"task\"\(title,date,status) values(\'%@\',\'%@\',\'PENDING\')",title,date];
    const char* insertStatement = [insertStatementNS UTF8String];
    dbResultCode = sqlite3_prepare_v2(db, insertStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
    [self closeConnectionAndFinalise];
}

-(void)addSubtask:(NSString*)title taskid:(NSInteger)taskId{
    if([self isConnectionAlive:dbResultCode]) return ;
    NSString *insertStatementNS = [NSString stringWithFormat:@"insert into \"subtask\"\(title,taskId,status) values(\'%@\',%d,\'PENDING\')",title,taskId];
    const char* insertStatement = [insertStatementNS UTF8String];
    dbResultCode = sqlite3_prepare_v2(db, insertStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
    [self closeConnectionAndFinalise];
}

-(void)closeConnectionAndFinalise{
    sqlite3_finalize(dbps);
    sqlite3_close(db);
}

- (BOOL)isConnectionAlive:(int)newDbResultCode {
    if(newDbResultCode){
        NSLog(@"coudnt open");
    }
    return dbResultCode;
}

- (NSMutableArray*)getData:(NSMutableArray*) array forStatus:(NSString*) status{
    int i=0;
    if([self isConnectionAlive:dbResultCode]) return 0;
    NSString *queryStatementNS = [NSString stringWithFormat:@"select * from task where status = \'%@\' order by id desc",status];
    const char* queryStatement = [queryStatementNS UTF8String];

    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    while((dbResultCode = sqlite3_step(dbps)) == SQLITE_ROW){
        int firstColumn = sqlite3_column_int(dbps, 0);
        NSNumber *id = [[NSNumber alloc]initWithInt:firstColumn];
        NSString *title = [ [NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 1)];
        NSString *date = [[NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 2)];
        row = [[TaskRow alloc]init];
        row.todoId = id;
        row.todoTitle = title;
        row.date = date;

        [array insertObject:row atIndex:i];
        i++;
     }
    [self closeConnectionAndFinalise];
    return array;
}

-(NSMutableArray*)getSubtask:(NSMutableArray*) array forTaskId:(NSInteger)taskId{
    int i=0;
    if([self isConnectionAlive:dbResultCode]) return 0;
    NSString *queryStatementNS = [NSString stringWithFormat:@"select id,title,status from subtask where taskId = %d order by id desc",taskId];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    
    while((dbResultCode = sqlite3_step(dbps)) == SQLITE_ROW){
        int firstColumn = sqlite3_column_int(dbps, 0);
        NSNumber *id = [[NSNumber alloc]initWithInt:firstColumn];
        NSString *title = [ [NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 1)];
        NSString *newstatus = [ [NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 2)];
        row = [[TaskRow alloc]init];
        row.todoId = id;
        row.todoTitle = title;
        row.status = newstatus;
        [array insertObject:row atIndex:i];
        i++;
    }
    [self closeConnectionAndFinalise];
    return array;
}

- (TaskRow*)getMaxRecord:(TaskRow*) NewTaskRow {
    if([self isConnectionAlive:dbResultCode]) return 0;
    NSString *queryStatementNS = [NSString stringWithFormat:@"select max(id),title,date from task"];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    
    while((dbResultCode = sqlite3_step(dbps)) == SQLITE_ROW){
        
        int firstColumn = sqlite3_column_int(dbps, 0);
        NSNumber *id = [[NSNumber alloc]initWithInt:firstColumn];
        NSString *title = [ [NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 1)];
        NSString *date = [[NSString alloc] initWithUTF8String:(char*) sqlite3_column_text(dbps, 2)];
       
        NewTaskRow.todoId = id;
        NewTaskRow.todoTitle = title;
        NewTaskRow.date = date;
    }
    
    [self closeConnectionAndFinalise];
    return NewTaskRow;
}

-(void) deleteRow:(NSNumber*)todoId{
    if([self isConnectionAlive:dbResultCode]) return;
    NSString *queryStatementNS = [NSString stringWithFormat:@"delete from task where id=%d",[todoId integerValue]];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
        
    [self closeConnectionAndFinalise];
}

-(void) updateStatus:(NSNumber*)todoId {
    if([self isConnectionAlive:dbResultCode]) return;
    NSString *queryStatementNS = [NSString stringWithFormat:@"update task set status = 'COMPLETED' where id = %d",[todoId integerValue]];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
    
    [self closeConnectionAndFinalise];
}

-(void) updateStatusForSubtask:(NSNumber*)todoId{
    if([self isConnectionAlive:dbResultCode]) return;
    NSString *queryStatementNS = [NSString stringWithFormat:@"update subtask set status = 'COMPLETED' where id = %d",[todoId integerValue]];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
    
    [self closeConnectionAndFinalise];
}

-(void)deleteSubTaskRow:(NSNumber *)subTaskId{
    if([self isConnectionAlive:dbResultCode]) return;
    NSString *queryStatementNS = [NSString stringWithFormat:@"delete from subtask where id=%d",[subTaskId integerValue]];
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
    
    [self closeConnectionAndFinalise];
}


@end
