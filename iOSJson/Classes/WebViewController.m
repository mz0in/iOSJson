//
//  WebViewController.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    
    // Asignamos delegado
    self.webView.delegate = self;
    
    //web que queremos cargar
    [self loadRequestFromString:@"http://speakinbytes.com/2014/03/ios-uiwebview-creando-nuestro-propio-browser"];
    
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

#pragma mark -
#pragma mark - webView delegate
#pragma mark -
- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    // Si falla la carga
    [self.spinner stopAnimating];
    self.lbLoad.hidden=YES;
    
	// Si es error -999 no lo tenemos en cuenta
	if (error.code == NSURLErrorCancelled) return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)web
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    //Activamos el activity y mostramos el label de cargando hasta que se cargue definitivamente la web
    [self.lbLoad setHidden:NO];
    [self.spinner setHidesWhenStopped:YES];
    [self.spinner setHidden:NO];
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)web
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    //ocultamos el activity y el label cargando cuando todo ha ido bien
    [self.spinner stopAnimating];
    self.lbLoad.hidden=YES;
    
}

#pragma mark - alert view delegate
// Para saber que botón de la alerta hemos pulsado. Para ello en el .h hemos añadido el delegado de las alertas
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - utils
- (void) initElements
{
    self.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"WEB_VIEW_TITLE", nil)];
    [self.lbLoad setText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"WEB_VIEW_BN_LOAD", nil)]];
    
}

- (void)updateButtons
{
    self.btnForward.enabled = self.webView.canGoForward;
    self.btnBack.enabled = self.webView.canGoBack;
    self.btnStop.enabled = self.webView.loading;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
