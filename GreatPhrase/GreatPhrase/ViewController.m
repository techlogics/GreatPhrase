//
//  ViewController.m
//  GreatPhrase
//
//  Created by kenichi on 9/28/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//
//
//
//
//
//
/******************************************************************
- "次へ"ボタンでランダムに名言を表示する機能の実装 ->
- "一覧ボタン"にすべての名言を表示する機能の実装 ->
- ローカル通知の実装 -> UILocalNotification
- "★"でお気に入り機能の実装 ->
- 新しく追加する際はPhraseList.jsonに番号名前名言を追加すること
-
*******************************************************************/

#import "ViewController.h"
#import "WikiViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _listButton.layer.cornerRadius = 40.0;
    _favoriteButton.layer.cornerRadius = 40.0;
    _peopleImage.layer.cornerRadius = 40.0;
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"PhraseList" ofType:@"json"];
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData * data = [fileHandle readDataToEndOfFile];
    _phraseList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    // スワイプで名言切り替え -> swipeRight, swipeLeft
    UISwipeGestureRecognizer * rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipe.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:rightSwipe];
    UISwipeGestureRecognizer * leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipe.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:leftSwipe];
    
    
    _phraseLabel.numberOfLines = 0; // 行数無制限
    _phraseLabel.lineBreakMode = NSLineBreakByWordWrapping;
    int randomKey = arc4random() % _phraseList.count;
    NSString * phrase = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"phrase"];
    NSString * name = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _peopleLabel.text = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _phraseLabel.text = [NSString stringWithFormat:@"%@", phrase];
    _wikiUrl = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"url"];
    _peopleImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
    
    
    //------通知登録------//
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now = [NSDate date];
    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: now];
    
    // 時間帯を固定
    [componentsForFireDate setHour: 8];
    [componentsForFireDate setMinute:0] ;
    [componentsForFireDate setSecond:0] ;
    [componentsForFireDate setTimeZone:[NSTimeZone defaultTimeZone]];
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc] init];
    
    // 一日ごとに通知を送る
    notifyAlarm.repeatInterval = NSCalendarUnitDay;
    
    notifyAlarm.fireDate = [calendar dateFromComponents:componentsForFireDate];
    NSLog(@"fireDate is %@",notifyAlarm.fireDate);
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    
    // 通知するメッセージ
    notifyAlarm.alertBody = [NSString stringWithFormat:@"%@ - %@", phrase, name];
    // ダイアログで表示されたときのボタンの文言
    notifyAlarm.alertAction = @"Open";
    //UILocalNotificationを実行する
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 右にスワイプでランダムにフレーズ切り替え
- (void)swipeRight:(UIGestureRecognizer *)gesture
{
    int randomKey = arc4random() % _phraseList.count;
    NSString * phrase = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"phrase"];
    NSString * name = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _peopleLabel.text = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _phraseLabel.text = [NSString stringWithFormat:@"%@", phrase];
    _wikiUrl = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"url"];
    _peopleImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
}

// 左のスワイプでランダムにフレーズ切り替え
- (void)swipeLeft:(UIGestureRecognizer *)gesture
{
    int randomKey = arc4random() % _phraseList.count;
    NSString * phrase = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"phrase"];
    NSString * name = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _peopleLabel.text = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"name"];
    _phraseLabel.text = [NSString stringWithFormat:@"%@", phrase];
    _wikiUrl = _phraseList[[NSString stringWithFormat:@"%d", randomKey]][@"url"];
    _peopleImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
}

// お気に入りに登録
- (IBAction)favorite:(id)sender
{
    
}

// wikiへの移動
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"wikiSegue"] ) {
        WikiViewController *wikiViewController = [segue destinationViewController];
        wikiViewController.url = _wikiUrl;
    }
}

// ナビゲーションバーを消す処理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
