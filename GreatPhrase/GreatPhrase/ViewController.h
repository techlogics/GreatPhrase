//
//  ViewController.h
//  GreatPhrase
//
//  Created by kenichi on 9/28/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;
@property (weak, nonatomic) IBOutlet UIButton *name;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UIButton *wikiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *buttonImage;

- (IBAction)share:(id)sender;

@property NSDictionary * phraseList;
@property NSString * wikiUrl;

@end

