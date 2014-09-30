//
//  WikiViewController.m
//  GreatPhrase
//
//  Created by Kenichi on 9/29/14.
//  Copyright (c) 2014 TechLogics. All rights reserved.
//

#import "WikiViewController.h"
#import "ViewController.h"

@interface WikiViewController ()

@end

@implementation WikiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wikiWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.wikiWebView.delegate = self;
    [self.view addSubview:self.wikiWebView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.wikiWebView loadRequest:urlRequest];
    
    [self startActivityIndicatorAnimation];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)startActivityIndicatorAnimation
{
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _indicator.center = self.view.center;
    _indicator.hidesWhenStopped = YES;
    [_indicator startAnimating];
    [self.view addSubview:_indicator];
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
