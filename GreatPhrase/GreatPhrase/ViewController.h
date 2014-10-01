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
@property (weak, nonatomic) IBOutlet UIButton *name;

- (IBAction)favorite:(id)sender;
- (IBAction)goWiki:(id)sender;

@property NSDictionary * phraseList;
@property NSString * wikiUrl;

@end

