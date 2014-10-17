//
//  LocalNotificationSettings.h
//  GreatPhrase
//
//  Created by Kenichi Saito on 10/14/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SettingsTableViewController.h"

@interface LocalNotificationSettings : NSObject

+ (void)setLocalNotificationWith:(NSDate *) date;
@end
