//
//  ViewController.m
//  MySafari
//
//  Created by roshan on 01/10/2014.
//  Copyright (c) 2014 learningIOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *titleBar;
@property (weak, nonatomic) IBOutlet UILabel *navigationLabel;



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.urlTextField becomeFirstResponder];






    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onBackButtonPressed:(UIButton *)sender {

    [self.webView goBack];

}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {


    [self.webView goForward];

}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {

    [self.webView stopLoading];

}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {

    [self.webView reload];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

     NSString *urlString = textField.text;

    BOOL result = [[urlString lowercaseString] hasPrefix:@"http://"];

    if(result)
    {

        [self loadPage:urlString];

    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@%@", @"http://", urlString];
        [self loadPage:urlString];

    }

    self.urlTextField.text = urlString;

    return YES;
}


-(void)loadPage:(NSString *) urlString{

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

}

- (IBAction)plusButtonPressed:(UIButton *)sender {

    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Coming Soon";
    [alertView addButtonWithTitle:@"Close"];
    [alertView show];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        if(self.webView.canGoBack)
        {
            self.backButton.hidden = NO;
        }
        if(self.webView.canGoForward)
        {
            self.forwardButton.hidden = NO;
        }

    NSString *myString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@", myString);
    self.navigationLabel.text = myString;

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL *aURL = [request URL];
    NSString *myString = [aURL absoluteString];
    NSLog(@"%@", myString);
    self.urlTextField.text = myString;





    return YES;
}







@end
