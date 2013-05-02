    //
//  NewsDetail.m
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsDetail.h"
#import "Final_ProjectAppDelegate.h"
#import "FeedRecord.h"


@implementation NewsDetail
@synthesize titleTextView,descriptionTextView,toolbar;
@synthesize image=_image;
@synthesize title1;
@synthesize description1;
@synthesize link1;
@synthesize news;
@synthesize medialink1;
//response to the addBookMark Button
-(IBAction) addBookMark:(id)sender
{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *bookmarks = appDelegate.feedlist;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have already added it to BookMarks" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
	[alert show];
	[alert release];
	
	FeedRecord *record;
	record = [[FeedRecord alloc] init];
	record.name = title1;
	record.url = link1;
	record.description = description1;
	[bookmarks addBookMarks:record];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	//create a bookMarkButton
	UIBarButtonItem *bookMarkButton = [[UIBarButtonItem alloc] 
									   initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks 
									   target:self 
									   action:@selector(addBookMark:)];
	self.navigationItem.rightBarButtonItem = bookMarkButton;
	//set the mediaUrl get from the RootViewController which is parsed from the XML file
	NSString * mediaUrl = medialink1;
	[[self image]setImage:[UIImage imageNamed:@"unknown.jpg"]];
	if(nil != mediaUrl){
		NSData* imageData;
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		@try {
		
			NSURL *myURL = [NSURL URLWithString:mediaUrl];
			imageData = [[NSData alloc]initWithContentsOfURL:myURL];
		}
		@catch (NSException * e) {
		}
		@finally {
			UIImage * imageFromImageData = [[UIImage alloc] initWithData:imageData];
			[[self image]setImage:imageFromImageData];
			[imageData release];
			[imageFromImageData release];
		}
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	
	self.titleTextView.text=title1;
	self.descriptionTextView.text=description1;
	//self.descriptionTextView.text = [[[self appDelegate] currentlySelectedBlogItem]description]; 
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]
									 initWithBarButtonSystemItem:UIBarButtonSystemItemAction
									 target:self action:@selector(openWebLink)];
	NSArray *items = [NSArray arrayWithObjects: actionButton,  nil];
	[self.toolbar setItems:items animated:NO];
	[actionButton release];
	
}

//the method used to open the link through the safari
-(void)openWebLink{
	// open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to open current item in browser?"
															 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"OK" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showFromToolbar:toolbar];
	[actionSheet release];	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSLog(@"link1:%@",link1);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:link1]];

	}
}
//hide the tab bar
-(BOOL)hidesBottomBarWhenPushed{
	return TRUE;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	

    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	news=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[news release];
	[titleTextView release];
	[descriptionTextView release];
	[toolbar release];
    [super dealloc];
}


@end
