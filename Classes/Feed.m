    //
//  Feed.m
//  Final_Project
//
//  Created by Student on 3/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Feed.h"
#import "RootViewController.h"
#import "Final_ProjectAppDelegate.h"


@implementation Feed
@synthesize feedsArray;
@synthesize rootViewController,category1;

//set the status bar color to black
- (void)viewWillAppear:(BOOL)animated {
  
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

//find the approriate entry depends on the category we chose
-(void) searchInCategory:(NSString *)category{
	NSInteger x;
	NSString *mycategory;
	
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	[feedsArray release];
	
	feedsArray=[[NSMutableArray alloc]init];
	FeedRecord *record=[[FeedRecord alloc] init];
	//go through all the entries in the data
	for (x=0;x<[feeds numFeeds];x++)
	{
		record=[feeds getFeedAtIndex:x];
		if ([[record category] isEqualToString:category1])
		{
			mycategory=[record name];
			if (![feedsArray containsObject:mycategory]) {
				[feedsArray addObject:mycategory];
			}
		}
	}	
	[feedsTableView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated{
	[self searchInCategory:category1];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.feedsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell
	NSInteger row=[indexPath row];
	cell.textLabel.text=[feedsArray objectAtIndex:row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
		
	//grab the row
	NSInteger row=[indexPath row];
	if (self.rootViewController==nil){
		RootViewController *arootView=[[RootViewController alloc]initWithNibName:@"RssFunViewController" bundle:nil];
		//set rootviewcontroller property
		self.rootViewController=arootView;
		[arootView release];
	}	

	rootViewController.title=[NSString stringWithFormat:@"%@",[feedsArray objectAtIndex:row]];
	NSString *feed=[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]] textLabel].text;
	rootViewController.feedName1=feed;
	[self.navigationController pushViewController:rootViewController animated:YES];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	feedsTableView=nil;
	self.rootViewController=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[feedsTableView release];
	[feedsArray release];
	[rootViewController release];
    [super dealloc];
}


@end
