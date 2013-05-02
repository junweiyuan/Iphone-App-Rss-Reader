    //
//  CategoryTableViewController.m
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "Feed.h"
#import "Final_ProjectAppDelegate.h"
@implementation CategoryTableViewController
@synthesize categoryArray;
@synthesize feedViewController;

-(void) viewDidAppear:(BOOL) animated{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	NSInteger j;
	NSString *myCategory;
	NSMutableArray *categoryArray1=[[NSMutableArray alloc]init];
	//go through all the entries in my database
	j=0;
	while(j<[feeds numFeeds])
	{
		FeedRecord *record=[feeds getFeedAtIndex:j];
		myCategory=[record category];
		
		if(myCategory==nil)
			break;
		//to neglect the duplicate item
		if([categoryArray1 indexOfObject:myCategory]>[categoryArray1 count]){
			[categoryArray1 addObject:myCategory];
		}
		j++;
	}
	[self setCategoryArray:categoryArray1];
	[categoryArray1 release];
	[categoryTableView reloadData];
}	

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title=@"Category";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell
	NSInteger row=[indexPath row];
	cell.textLabel.text=[categoryArray objectAtIndex:row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	[UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationRepeatAutoreverses:NO];
	
	
	//grab the row
	NSInteger row=[indexPath row];
	if (self.feedViewController==nil){
		Feed *afeedView=[[Feed alloc]initWithNibName:@"feedTableView" bundle:nil];
		self.feedViewController=afeedView;
		[afeedView release];
	}	

	NSString *cateogry=[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]textLabel].text;
	//send the selected category value to the next viewController
	feedViewController.category1=cateogry;
	
	feedViewController.title=[NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:row]];
	
	[self.navigationController pushViewController:feedViewController animated:YES];
	
	[UIView commitAnimations];

}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	feedViewController=nil;
	categoryTableView=nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[categoryTableView release];
	[feedViewController release];
	[categoryArray release];
    [super dealloc];
}


@end
