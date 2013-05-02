    //
//  searchViewController.m
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "searchViewController.h"



@implementation searchViewController

@synthesize webView;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	    NSString *urlAddress=@"http://www.google.com";
	
	//Create a URL object
	NSURL *url=[NSURL URLWithString:urlAddress];
	//Create URL Request Object
	NSURLRequest *requestObj=[NSURLRequest requestWithURL:url];
	//Load the request in the UIWebView
	[webView loadRequest:requestObj];
	[super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
    [super dealloc];
}


@end
