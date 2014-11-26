//
//  SettingsTableViewController.m
//  GreatPhrase
//
//  Created by Kenichi Saito on 10/14/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController () <UIAlertViewDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [_notificationSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [_notificationDate addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (void)switchChanged:(UISwitch *)switchParts {
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    if (_notificationSwitch.on) {
        [setting setInteger:1 forKey:@"notification"];
        [setting synchronize];
        NSLog(@"%@", [setting objectForKey:@"notification"]);
    } else {
        [setting setInteger:0 forKey:@"notification"];
        [setting synchronize];
        NSLog(@"%@", [setting objectForKey:@"notification"]);
    }
}


- (void)dateChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"H:mm"];
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponetsOnSystemTimeZone = [[NSDateComponents alloc] init];
    [dateComponetsOnSystemTimeZone setTimeZone:[NSTimeZone systemTimeZone]];
    dateComponetsOnSystemTimeZone = [currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:datePicker.date];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setObject:[dateFormatter stringFromDate:datePicker.date] forKey:@"date"];
    [setting setInteger:[dateComponetsOnSystemTimeZone hour] forKey:@"hour"];
    [setting setInteger:[dateComponetsOnSystemTimeZone minute] forKey:@"minute"];
    [setting synchronize];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [dateComponetsOnSystemTimeZone setHour:[setting integerForKey:@"hour"]];
    [dateComponetsOnSystemTimeZone setMinute:[setting integerForKey:@"minute"]];
    [dateComponetsOnSystemTimeZone setSecond:0];
    NSLog(@"fireDate確認ログ：dateComponentsOnSystemTimeZone:%@", dateComponetsOnSystemTimeZone);
    NSDate *date = [currentCalendar dateFromComponents:dateComponetsOnSystemTimeZone];
    UILocalNotification *notifyAlarm = [[UILocalNotification alloc] init];
    notifyAlarm.repeatInterval = NSCalendarUnitDay;
    notifyAlarm.fireDate = date;
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
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
    
    
    NSLog(@"%@", [dateFormatter stringFromDate:datePicker.date]);
    NSLog(@"%ld - %ld", (long)[setting integerForKey:@"hour"], (long)[setting integerForKey:@"minute"]);
    
    NSString *alertBody = [NSString stringWithFormat:@"%@で設定しました。", [dateFormatter stringFromDate:datePicker.date]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:alertBody delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [self.view addSubview:alert];
    [alert show];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
