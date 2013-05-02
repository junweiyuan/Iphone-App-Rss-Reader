//
//  searchViewController.m
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Final_ProjectAppDelegate.h"
#import "NewsDetail.h"



@implementation RootViewController
@synthesize newsDetail;
@synthesize feedName1;
@synthesize activityIndicator;

//respond to refresh button
-(IBAction) refresh:(id)sender
{
	[self searchInFeed:feedName1];
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	//create a refreshButton on the Navigation Bar
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] 
									   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
									   target:self 
									   action:@selector(refresh:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
}
//it is used for activityIndicator to control when begin to show the indicator
-(void) rootViewDidStartLoad:(RootViewController *) rootiview{
	[activityIndicator startAnimating];
	activityIndicator.hidden=NO;
	[self.view bringSubviewToFront:activityIndicator];
}

-(void) rooViewDidFinishLoad:(RootViewController *) rootview{
	[activityIndicator stopAnimating];
	activityIndicator.hidden=YES;
}
-(void) searchInFeed:(NSString *)feedName{
	NSInteger y;
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	FeedRecord *record=[[FeedRecord alloc]init];
	//select the approriate entries depends on the feedName we get from Feed Controller
	for (y=0;y<[feeds numFeeds];y++)
	{
		record=[feeds getFeedAtIndex:y];
		if ([[record name] isEqualToString:feedName1])
		{
			NSString * path =[record url]; 
			
		[self parseXMLFileAtURL:path];
		}
    }
}
- (void)viewDidLoad {
}

- (void) viewDidAppear:(BOOL)animated{
	[self searchInFeed:feedName1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//grab the row
	NSInteger rows=[indexPath row];
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;

	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rssItemCell"];
	if(nil == cell){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rssItemCell"]autorelease];
	}
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	//To see whether we read the news or not
	NSUInteger storyvalue = [feeds getReadAtIndex:rows];
	UIImage *image;
	if(storyvalue == 0)
		image=[UIImage imageNamed:@"UnreadIndicator.png"];
	else {
		image=[UIImage imageNamed:@"ReadIndicator.png"];

	}
		//set the cell image
		cell.image=image;
		//set the textLabel content as the news headline
		cell.textLabel.text=[[stories objectAtIndex: storyIndex] objectForKey: @"title"];
		//set the detailTextlabel content as the new date
		cell.detailTextLabel.text=[[stories objectAtIndex:storyIndex] objectForKey:@"date"];
		//set the cell type as accessory type
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	newsDetail=[[NewsDetail alloc]init];
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	[feeds.read insertObject:[NSNumber numberWithInt:1] atIndex:[indexPath row]];
	//grab the row
	NSInteger row=[indexPath row];
	if (self.newsDetail==nil){
		NewsDetail *anewsView=[[NewsDetail alloc]initWithNibName:@"NewsDetail" bundle:nil];
		//set rootviewcontroller property
		anewsView.hidesBottomBarWhenPushed=YES;
		self.newsDetail=anewsView;
		[anewsView release];
	}	
	newsDetail.title1=[[stories objectAtIndex: row] objectForKey: @"title"];
	newsDetail.description1=[[stories objectAtIndex:row] objectForKey: @"summary"];
	newsDetail.link1=[[stories objectAtIndex:row] objectForKey:@"link"];
	newsDetail.medialink1=[[stories objectAtIndex:row] objectForKey:@"media"];
	[self.navigationController pushViewController:newsDetail animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
}


//For the following part, for how to pase the XML files, i learn the steps on the internet, but i do some changes, you can see it through my comment
- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	[self rootViewDidStartLoad:nil];
	stories = [[NSMutableArray alloc] init];
	
    //convert the path to a proper NSURL
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    //alloc NSXMLParser
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser    
	[rssParser setDelegate:self];
	
    //disable the following features of NSXMLParser
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out the story item caches
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
		currentImage=[[NSMutableString alloc] init];
	}
	if([currentElement isEqualToString:@"media:thumbnail"]){
		//since there are two image links, i just append the first link
		if (![currentImage length]) {
		[currentImage appendString:[attributeDict objectForKey:@"url"]];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		[item setObject:currentImage forKey:@"media"];
		
		[stories addObject:[item copy]];
		NSUInteger story = 0;
		Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
		FeedDatabase *feeds = appDelegate.feedlist;
		[feeds addRead:story];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	// save the characters for the current item
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
	//since there are two links, actually i just need the first one	
	if(![currentLink length]){
			
		[currentLink appendString:string];
	}
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	} 
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[newsTable reloadData];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)viewDidUnload {
    [super viewDidUnload];
	newsTable=nil;
	self.newsDetail=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[currentElement release];
	[rssParser release];
	[stories release];
	[item release];
	[currentTitle release];
	[currentDate release];
	[currentSummary release];
	[currentLink release];
	[newsTable release];
	[newsDetail release];

	
	[super dealloc];
}


@end

