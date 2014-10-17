//
//  LocalNotificationSettings.m
//  GreatPhrase
//
//  Created by Kenichi Saito on 10/14/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import "LocalNotificationSettings.h"

@implementation LocalNotificationSettings

+ (void)setLocalNotificationWith:(NSDate *)date
{
    //------通知登録------//
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: date];
    
    // 時間帯を固定 -> 8:00
    [componentsForFireDate setHour: componentsForFireDate.hour];
    [componentsForFireDate setMinute: componentsForFireDate.minute];
    [componentsForFireDate setSecond:0];
    [componentsForFireDate setTimeZone:[NSTimeZone defaultTimeZone]];
    UILocalNotification * notifyAlarm = [[UILocalNotification alloc] init];
    
    // 一日ごとに通知を送る
    notifyAlarm.repeatInterval = NSCalendarUnitDay;
    notifyAlarm.fireDate = [calendar dateFromComponents:componentsForFireDate];
    NSLog(@"fireDate is %@",notifyAlarm.fireDate);
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    
    // 通知するメッセージ
    // notifyAlarm.alertBody = [NSString stringWithFormat:@"%@ - %@", phrase, name];
    
    // ダイアログで表示されたときのボタンの文言
    notifyAlarm.alertAction = @"Open";
    
    //UILocalNotificationを実行する
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
    
    //---通知登録終わり---//
}

@end
