//
//  taskData.m
//  ToDoApp
//
//  Created by gauravm on 22/08/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "TaskDataModel.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#import "TaskRow.h"
@implementation TaskDataModel
int i=0;

-(void)inserttitle:(NSString*)title anddate:(NSString*)date{
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
    dbResultCode = sqlite3_open(dbFilePathUTF8,&db);
    if(dbResultCode){
        NSLog(@"coudnt open");
    }
    
    sqlite3_stmt *dbps;
    NSString *insertStatementNS = [NSString stringWithFormat:@"insert into \"task\"\(title,date) values(\'%@\',\'%@\')",title,date ];

    const char* insertStatement = [insertStatementNS UTF8String];    
    dbResultCode = sqlite3_prepare_v2(db, insertStatement, -1, &dbps, NULL);
    
    dbResultCode = sqlite3_step(dbps);
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    }




- (NSMutableArray*)getData:(NSMutableArray*) array {
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    dbResultCode = sqlite3_open(dbFilePathUTF8,&db);
    if(dbResultCode){
        NSLog(@"coudnt open");
    }
    sqlite3_stmt *dbps;
    NSString *queryStatementNS = [NSString stringWithFormat:@"select * from task"];
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
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    return array;
}

- (TaskRow*)getMaxRecord:(TaskRow*) NewTaskRow {
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    dbResultCode = sqlite3_open(dbFilePathUTF8,&db);
    if(dbResultCode){
        NSLog(@"coudnt open");
    }
    sqlite3_stmt *dbps;
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
    
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    return NewTaskRow;
}
-(void) deleteRow:(NSNumber*)todoId
{
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    dbResultCode = sqlite3_open(dbFilePathUTF8,&db);
    if(dbResultCode){
        NSLog(@"coudnt open");
    }
    sqlite3_stmt *dbps;
    NSString *queryStatementNS = [NSString stringWithFormat:@"delete from task where id=%d",[todoId integerValue]];
    NSLog(@"statemwnt %@",queryStatementNS);
    const char* queryStatement = [queryStatementNS UTF8String];
    
    dbResultCode = sqlite3_prepare_v2(db, queryStatement, -1, &dbps, NULL);
    dbResultCode = sqlite3_step(dbps);
        
    sqlite3_finalize(dbps);
    sqlite3_close(db);

}



@end
