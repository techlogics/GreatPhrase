//
//  LocalNotificationManager.m
//  GreatPhrase
//
//  Created by Kenichi Saito on 11/20/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import "LocalNotificationManager.h"

@implementation LocalNotificationManager

+ (void)setLocalNotification {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now = [NSDate date];
    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: now];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSDate *date = [setting objectForKey:@"date"];

    
    // [componentsForFireDate setHour:];
    // [componentsForFireDate setMinute:];
    // [componentsForFireDate setSecond:0];
    [componentsForFireDate setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSLog(@"%@", componentsForFireDate.date);
    
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc] init];
    // 一日ごとに通知を送る
    notifyAlarm.repeatInterval = NSCalendarUnitDay;
    
    notifyAlarm.fireDate = date;
    // [calendar dateFromComponents:componentsForFireDate];
    NSLog(@"fireDate is %@",notifyAlarm.fireDate);
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"PhraseList" ofType:@"json"];
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData * data = [fileHandle readDataToEndOfFile];
    NSDictionary * phraseList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    int randomKey = arc4random() % phraseList.count;
    NSString * phrase = phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"phrase"];
    NSString * name = phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    notifyAlarm.alertBody = [NSString stringWithFormat:@"%@ - %@", phrase, name];
    
    //UILocalNotificationを実行する
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
}
@end
