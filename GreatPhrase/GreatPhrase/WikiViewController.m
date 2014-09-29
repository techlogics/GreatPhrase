//
//  WikiViewController.m
//  GreatPhrase
//
//  Created by Kenichi on 9/29/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import "WikiViewController.h"

@interface WikiViewController ()

@end

@implementation WikiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wikiWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.wikiWebView.delegate = self;
    [self.view addSubview:self.wikiWebView];
    
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.wikiWebView loadRequest:urlRequest];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
