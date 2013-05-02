    //
//  FeedInfoViewController.m
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedInfoViewController.h"
#import "Final_ProjectAppDelegate.h"
#import "FeedDetailViewController.h"


@implementation FeedInfoViewController

@synthesize feedsArray1;
@synthesize category2;
@synthesize myFeedInfoView;
@synthesize feedDetailView1;


-(void) searchInCategory:(NSString *)category{
	NSInteger x;
	NSString *mycategory;
	
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
//	[feedsArray1 release];
	feedsArray1 =nil;
	NSMutableArray *tempfeedsArray=[[NSMutableArray alloc]init];
	FeedRecord *record=[[FeedRecord alloc] init];
	for (x=0;x<[feeds numFeeds];x++)
	{
		record=[feeds getFeedAtIndex:x];
		NSLog (@"FFFFFF%@",category2);

		if ([[record category] isEqualToString:category2])
		{
			if(![record.name isEqualToString:@""])
			{	
			mycategory=[record name];
			if (![tempfeedsArray containsObject:mycategory]) {
				[tempfeedsArray addObject:mycategory];
				NSLog (@"xxxx%@",mycategory);
			}
			}	
		}
	}	
	feedsArray1=tempfeedsArray;
	//[tempfeedsArray release];
	[feedsTableView1 reloadData];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	
	//remove the contact in contact database
	[feeds removeFeedAtIndex:[indexPath row]];
	//remove the contact in the nameArray1 which used to draw the nametableview
	[self.feedsArray1 removeObjectAtIndex:[indexPath row]];
	NSArray *deletePaths = [NSArray arrayWithObject:indexPath];
	[tableView deleteRowsAtIndexPaths:deletePaths
					 withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				target:self
																				action:@selector(addAction:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}


- (IBAction)addAction:(id)sender
{		
	MyFeedInfoView *feedDetail = [[MyFeedInfoView alloc] initWithNibName:@"MyFeedInfoView" bundle:nil];
	self.myFeedInfoView= feedDetail;
	[feedDetail release];
	[self presentModalViewController:myFeedInfoView animated:YES];
}	

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	UIColor *background =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor=background;
	[background release];	
	
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated{
	[self searchInCategory:category2];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.feedsArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell
	NSInteger row=[indexPath row];
	cell.textLabel.text=[feedsArray1 objectAtIndex:row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//grab the row
	NSInteger row=[indexPath row];
	if (self.feedDetailView1==nil){
		FeedDetailViewController *adetailView=[[FeedDetailViewController alloc]initWithNibName:@"FeedDetailViewController" bundle:nil];
		//set rootviewcontroller property
		self.feedDetailView1=adetailView;
		[adetailView release];
	}	
	 NSString *feed=[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]] textLabel].text;
	
	 feedDetailView1.name1=feed;
	
	[self.navigationController pushViewController:feedDetailView1 animated:YES];
	
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
	feedsTableView1=nil;
	myFeedInfoView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[feedsArray1 release];
	[myFeedInfoView release];
	[feedDetailView1 release];
    [super dealloc];
}


@end
