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
- (IBAction)changePhrase:(id)sender;
- (IBAction)favorite:(id)sender;

@end

