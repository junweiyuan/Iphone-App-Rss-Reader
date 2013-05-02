    //
//  MyViewController.m
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"
#import "Final_ProjectAppDelegate.h"


@implementation MyViewController

@synthesize categoryField;
@synthesize descriptionField;


- (void)viewWillAppear:(BOOL)animated {
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    categoryField.text =@"";
	descriptionField.text =@"";
	[super viewWillAppear:animated];
	
}



-(IBAction) cancelButton{
	    UIActionSheet *actionEditing = [[UIActionSheet alloc]
										initWithTitle:@"Are you sure you leave ??"
										delegate:self
										cancelButtonTitle:@"YES"
										destructiveButtonTitle:@"NO"
										otherButtonTitles:nil ];
		[actionEditing showInView:self.view];
		[actionEditing release];
		[self.parentViewController dismissModalViewControllerAnimated:YES];
}

//Method to implement the done with button (common for add and edit)
-(IBAction) saveButton
{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;

	FeedRecord *record;
	record = [[FeedRecord alloc] init];
	record.description = descriptionField.text;
	record.category=categoryField.text;
	
	[feeds addFeed:record];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) keyboardHide
{
	
	[descriptionField resignFirstResponder];
	[categoryField resignFirstResponder];
}


//Implement the appropriate function according to the button pressed in the actionsheet
- (void) actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger) buttonIndex {
	if(buttonIndex == 1)
		[self.parentViewController dismissModalViewControllerAnimated:YES];
}




- (void)viewDidLoad {
	UIColor *background =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor=background;
	[background release];	
	
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
	[categoryField release];
	[descriptionField release];
	
    [super dealloc];
}


@end
