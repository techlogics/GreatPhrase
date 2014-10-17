//
//  SettingsTableViewController.h
//  GreatPhrase
//
//  Created by Kenichi Saito on 10/14/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property NSUserDefaults * userSettings;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@end
