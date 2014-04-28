//
//  RootViewController.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 20/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "RootViewController.h"
#import "NSURLViewController.h"
#import "MyJsonViewController.h"
#import "WebViewController.h"
#import "WebVideoViewController.h"
#import "ASIHTTPRequestViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initElements
{
    self.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_LB_TITLE", nil)];
    // [self.lbPractice setText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_LB_PRACTICE", nil)]];
    // [self.lbName setText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_LB_NAME", nil)]];
    // [self.txtInfo setText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_TXT_INFO", nil)]];
    [self.btnGoToTable setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_BTN_GO_NSRLCON", nil)] forState:UIControlStateNormal];
    [self.btnMyJson setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_BTN_GO_JSON", nil)] forState:UIControlStateNormal];
    [self.btnWeb setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_BTN_GO_WEBVIEW", nil)] forState:UIControlStateNormal];
    [self.btnVideo setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_BTN_GO_VIDEOVIEW", nil)] forState:UIControlStateNormal];
    [self.btnASI setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"ROOT_VIEW_BTN_GO_ASIHTTP", nil)] forState:UIControlStateNormal];
    
}

- (IBAction)goTable:(id)sender {
    NSURLViewController *nsurlViewController = [[NSURLViewController alloc] initWithNibName:@"NSURLViewController" bundle:nil];
    
    [self.navigationController pushViewController:nsurlViewController animated:YES];
}
- (IBAction)pushASIHTTP:(id)sender {
    ASIHTTPRequestViewController *asihttpViewController = [[ASIHTTPRequestViewController alloc] initWithNibName:@"ASIHTTPRequestViewController" bundle:nil];
    
    [self.navigationController pushViewController:asihttpViewController animated:YES];
}

- (IBAction)pushMyJson:(id)sender {
    MyJsonViewController *myJsonViewController = [[MyJsonViewController alloc] initWithNibName:@"MyJsonViewController" bundle:nil];
    
    [self.navigationController pushViewController:myJsonViewController animated:YES];
}

- (IBAction)pushWebView:(id)sender {
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)pushWebVideoView:(id)sender {
    WebVideoViewController *webVideoViewController = [[WebVideoViewController alloc] initWithNibName:@"WebVideoViewController" bundle:nil];
    
    [self.navigationController pushViewController:webVideoViewController animated:YES];
}
@end
