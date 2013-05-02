//
//  MyViewController.m
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyFeedInfoView.h"
#import "Final_ProjectAppDelegate.h"


@implementation MyFeedInfoView

@synthesize nameField;
@synthesize urlField;
@synthesize categoryField;
@synthesize descriptionField;



- (void)viewWillAppear:(BOOL)animated {
	nameField.text =@"";
	urlField.text =@"";
	categoryField.text =@"";
	descriptionField.text =@"";
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

-(IBAction) cancelButton{
	if(![nameField.text isEqualToString:@""])
	{
		UIActionSheet *actionEditing = [[UIActionSheet alloc]
										initWithTitle:@"Are you sure you leave ??"
										delegate:self
										cancelButtonTitle:@"YES"
										destructiveButtonTitle:@"NO"
										otherButtonTitles:nil ];
		[actionEditing showInView:self.view];
		[actionEditing release];
		
	}	
	else
		[self.parentViewController dismissModalViewControllerAnimated:YES];
}

//Method to implement the done with button (common for add and edit)
-(IBAction) saveButton
{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	
	FeedRecord *record;
	record = [[FeedRecord alloc] init];
	record.name = nameField.text;
	record.url = urlField.text;
	record.description = descriptionField.text;
	record.category=categoryField.text;
	[feeds addFeed:record];
	NSLog (@"newvalues %@",record.url);
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) keyboardHide
{
	[nameField resignFirstResponder];
	[urlField resignFirstResponder];
	[descriptionField resignFirstResponder];
	[categoryField resignFirstResponder];
}




//Implement the appropriate function according to the button pressed in the actionsheet
- (void) actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger) buttonIndex {
	if(buttonIndex == 1)
		[self.parentViewController dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 UIColor *background =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	 self.view.backgroundColor=background;
	 [background release];	
	 
     [super viewDidLoad];
     self.title=@"ABC";
}
 

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
	[nameField release];
	[urlField release];
	[categoryField release];
	[descriptionField release];
    [super dealloc];
}


@end
