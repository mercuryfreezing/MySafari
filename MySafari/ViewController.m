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
    [self updateButtons];

    self.urlTextField.keyboardType = UIKeyboardTypeURL;
    [self.urlTextField becomeFirstResponder];


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


//TextField Protocol Method
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




- (IBAction)plusButtonPressed:(UIButton *)sender {

    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Coming Soon";
    [alertView addButtonWithTitle:@"Close"];
    [alertView show];

}

//WebView Protocol Method
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self updateButtons];
}

//WebView Protocol Method
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    NSString *myString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@", myString);
    [self updateButtons];
    [self updateAddress:[webView request]];
    self.navigationLabel.text = myString;
}

//WebView Protocol Method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    [self updateAddress:request];
    [self updateButtons];
    return YES;
}

//Helper
-(void)loadPage:(NSString *) urlString{

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.urlTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.webView loadRequest:urlRequest];
    
}

//Helper
-(void) updateAddress:(NSURLRequest *) request
{
    NSURL *aURL = [request mainDocumentURL];
    NSString *myString = [aURL absoluteString];
    NSLog(@"%@", myString);
    self.urlTextField.text = myString;

}

//Helper
-(void) updateButtons{

    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}



@end
