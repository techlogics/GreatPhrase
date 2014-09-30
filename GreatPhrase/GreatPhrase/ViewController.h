//
//  ViewController.h
//  GreatPhrase
//
//  Created by kenichi on 9/28/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;
- (IBAction)changePhrase:(id)sender;
- (IBAction)favorite:(id)sender;

@property (weak, nonatomic) NSString * currentPhrase;
@property (weak, nonatomic) NSString * currentPeopleName;
@property NSArray * phraseList;
@property NSString * wikiUrl;
@end

