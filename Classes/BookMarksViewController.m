//
//  BookMarksViewController.m
//  Final_Project
//
//  Created by Student on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookMarksViewController.h"
#import "Final_ProjectAppDelegate.h"
#import "NewsWebViewController.h"

@implementation BookMarksViewController
@synthesize bookmarkArray;
@synthesize newsWebView;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}
-(void) viewDidAppear:(BOOL) animated{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *bookmarks = appDelegate.feedlist;
	NSInteger j;
	NSString *myTitle;
	NSMutableArray *titleArray1=[[NSMutableArray alloc]init];
	
	j=0;
	while(j<[bookmarks numBookMarks])
	{
		FeedRecord *record=[bookmarks getBookMarksAtIndex:j];
		myTitle=[record name];
		
		if(myTitle==nil)
			break;
		if([titleArray1 indexOfObject:myTitle]>[titleArray1 count]){
			[titleArray1 addObject:myTitle];
		}
		j++;
	}
	[self setBookmarkArray:titleArray1];
	[titleArray1 release];
	[bookmarksTable reloadData];
}	

-(NSInteger) tableView:(UITableView *) tableView 
 numberOfRowsInSection:(NSInteger) section{
	//return the number of rows in that section
	return [self.bookmarkArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *SimpleTableIdentifier=@"SimpleTableIdentifier";
	
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:
						   SimpleTableIdentifier];
	if(cell==nil){
		cell=[[[UITableViewCell alloc]
			   initWithStyle:UITableViewCellStyleValue1
			   reuseIdentifier:SimpleTableIdentifier] autorelease];
		//grab the row
		NSUInteger row=[indexPath row];
		//set the cell content to the stateArray
		cell.textLabel.text=[bookmarkArray objectAtIndex:row];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//grab the row
	
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *bookmarks = appDelegate.feedlist;
	NSInteger row=[indexPath row];
	if (self.newsWebView==nil){
		NewsWebViewController *awebView=[[NewsWebViewController alloc]initWithNibName:@"NewsWebViewController" bundle:nil];
		//set rootviewcontroller property
		self.newsWebView=awebView;
		[awebView release];
	}	
	FeedRecord* record =[bookmarks getBookMarksAtIndex:row];
	NSString *link=[record url];
	newsWebView.link1=link;
	[self.navigationController pushViewController:newsWebView animated:YES];
	
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"BookMarks";
}


- (void)viewDidUnload {
    [super viewDidUnload];
	bookmarksTable=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[bookmarkArray release];
	[bookmarksTable release];
    [super dealloc];
}


@end
