//
//  NewsWebViewController.m
//  Final_Project
//
//  Created by Student on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsWebViewController.h"


@implementation NewsWebViewController

@synthesize webView,link1;
@synthesize activityIndicator;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	webView.delegate = self;
	webView.scalesPageToFit=YES;

	[super viewDidLoad];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityIndicator startAnimating];
	activityIndicator.hidden=NO;
	[self.view bringSubviewToFront:activityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[activityIndicator stopAnimating];
	activityIndicator.hidden=YES;
	
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	webView.frame = self.view.frame;
}

- (void)viewWillAppear:(BOOL)animated{
	NSString *urlAddress=link1;
	NSURL *url=[NSURL URLWithString:urlAddress];

	//URL Request Object
	NSURLRequest *requestObj=[NSURLRequest requestWithURL:url];

	//Load the request in the UIWebView
	[webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	webView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
	[activityIndicator release];
    [super dealloc];
}


@end
