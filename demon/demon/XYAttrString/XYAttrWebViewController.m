//
//  XYWebViewController.m
//  demon
//
//  Created by MDJ on 2017/3/31.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYAttrWebViewController.h"

@interface XYAttrWebViewController ()<UIWebViewDelegate>
@property (nonatomic,weak) UIButton *backButton;
@end

@implementation XYAttrWebViewController
- (UIButton *)backButton{
    if (_backButton == nil) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 100, 60, 30);
        backButton.layer.cornerRadius = 5;
        backButton.layer.masksToBounds = YES;
        [backButton setTitle:@"back" forState:UIControlStateNormal];
        backButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        self.backButton = backButton;
    }
    return _backButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

#pragma mark - webViewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButton.alpha = 0.5;
    [UIView animateWithDuration:0.25 animations:^{
        self.backButton.alpha = 1;
    }];
}
- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"\n---------\n %@---dealloc\n---------",[self class]);
}

@end
