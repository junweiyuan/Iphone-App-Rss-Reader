//
//  FeedDetailViewController.m
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "Final_ProjectAppDelegate.h"
#import "FeedRecord.h"


@implementation FeedDetailViewController

@synthesize nameField;
@synthesize urlField;
@synthesize categoryField;
@synthesize descriptionField;
@synthesize name1;

- (void)viewDidLoad {
	UIColor *background =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor=background;
	[background release];	
	
    [super viewDidLoad];
}

-(IBAction) save:(id)sender
{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	
	NSInteger n;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You save successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
	[alert show];
	[alert release];
	
	for (n=0;n<[feeds numFeeds];n++)
	{
		FeedRecord *record=[feeds getFeedAtIndex:n];
		if([[record name] isEqualToString:name1])
		{
			//set the record information
			record.name = nameField.text;
			record.url = urlField.text;
			record.description = descriptionField.text;
			record.category=categoryField.text;
		}	
		[self keyboardHide];
	}		

}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
									   initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
									   target:self 
									   action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	
}


-(void) searchInName:(NSString *)name{
	NSInteger n;
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	for (n=0;n<[feeds numFeeds];n++)
	{
		FeedRecord *record=[feeds getFeedAtIndex:n];
		if([[record name] isEqualToString:name1])
		{
			//set the record information
			nameField.text=record.name;
			urlField.text=record.url;
			descriptionField.text=record.description;
			categoryField.text=record.category;
		}	
	}		
}



-(IBAction) keyboardHide
{
	[nameField resignFirstResponder];
	[urlField resignFirstResponder];
	[descriptionField resignFirstResponder];
	[categoryField resignFirstResponder];
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

- (void) viewDidAppear:(BOOL)animated{
	//the view in displayed on screen will call this method everytime, so the tableview can change 
	[self searchInName:name1];
	
}


- (void)dealloc {
	[nameField release];
	[urlField release];
	[categoryField release];
	[descriptionField release];
	
    [super dealloc];
}


@end
