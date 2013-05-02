//
//  CategoryTableViewController.m
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedCatInfoViewController.h"
#import "FeedInfoViewController.h"

//#import "FeedDatabase.h"
#import "Final_ProjectAppDelegate.h"

@implementation FeedCatInfoViewController
@synthesize categoryArray;
@synthesize feedViewController1;
@synthesize myViewController;




- (IBAction) toggleEditing {
	[categoryTableView1 setEditing:(! categoryTableView1.editing) animated:YES];
}


- (IBAction)addAction:(id)sender
{		
	
	MyViewController *categoryDetail = [[MyViewController alloc] initWithNibName:@"MyView" bundle:nil];
	self.myViewController = categoryDetail;
	[categoryDetail release];
	[self presentModalViewController:myViewController animated:YES];
}	
	
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.title =@"Feeds";
	[self viewDidAppear:YES];
	[self.tableView reloadData];
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				target:self
																				action:@selector(addAction:)] autorelease];
	self.navigationItem.leftBarButtonItem = addButton;
}


-(void) viewDidAppear:(BOOL) animated{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	NSInteger j;
	NSString *myCategory;
	NSMutableArray *categoryArray1=[[NSMutableArray alloc]init];
	
	j=0;
	while(j<[feeds numFeeds])
	{
		FeedRecord *record=[feeds getFeedAtIndex:j];
		myCategory=[record category];
		
		if(myCategory==nil)
			break;
			if (![categoryArray1 containsObject:myCategory]) {

			[categoryArray1 addObject:myCategory];
		}
		j++;
	}
	[self setCategoryArray:categoryArray1];
	[categoryArray1 release];
	[categoryTableView1 reloadData];
}	

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
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
	//grab the row
	NSInteger row=[indexPath row];
	if (self.feedViewController1==nil){
		FeedInfoViewController *afeedView=[[FeedInfoViewController alloc]initWithNibName:@"FeedInfo" bundle:nil];
		self.feedViewController1=afeedView;
		[afeedView release];
	}	
	
	NSString *cateogry=[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]textLabel].text;
	feedViewController1.category2=cateogry;
	
	feedViewController1.title=[NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:row]];
	
	[self.navigationController pushViewController:feedViewController1 animated:YES];
	
	
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;

	//remove the contact in contact database
	[feeds removeFeedAtIndex:[indexPath row]];
	//remove the contact in the nameArray1 which used to draw the nametableview
	[self.categoryArray removeObjectAtIndex:[indexPath row]];
	NSArray *deletePaths = [NSArray arrayWithObject:indexPath];
	[tableView deleteRowsAtIndexPaths:deletePaths
					 withRowAnimation:UITableViewRowAnimationFade];
}
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad {
	UIColor *background =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor=background;
	[background release];	
	
     [super viewDidLoad];
	 self.navigationItem.rightBarButtonItem=self.editButtonItem;
 }
 
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	categoryTableView1=nil;
	self.myViewController=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[feedViewController1 dealloc];
	[categoryArray release];
	[myViewController release];
    [super dealloc];
}


@end
