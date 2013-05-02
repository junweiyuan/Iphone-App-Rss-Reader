//
//  Final_ProjectAppDelegate.m
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Final_ProjectAppDelegate.h"
#import "RootViewController.h"

#import "FeedRecord.h"
#import "FeedDatabase.h"






@implementation Final_ProjectAppDelegate

@synthesize window;
@synthesize rootController;
@synthesize feedlist;

#pragma mark -
#pragma mark Application lifecycle


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	NSString *filename = [self archiveFilename];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
		[self loadData];
	} 
	else 
	{
	FeedRecord *ya=[[FeedRecord alloc] init];
	[ya setName:@"ESPN SPORTS"];
	[ya setUrl:@"http://newsrss.bbc.co.uk/rss/sportonline_world_edition/front_page/rss.xml"];
	[ya setDescription:@"ESPN"];
	[ya setCategory:@"Sports"];
	
	FeedRecord *bbc=[[FeedRecord alloc] init];
	[bbc setName:@"BBC Business"];
	[bbc setUrl:@"http://feeds.bbci.co.uk/news/business/rss.xml?edition=int"];
	[bbc setDescription:@"BBC"];
	[bbc setCategory:@"Business"];
		
	FeedRecord *ny=[[FeedRecord alloc] init]; 
	[ny setName:@"New York Times"];
	[ny setUrl:@"http://www.nytimes.com/services/xml/rss/userland/Business.xml"];	
	[ny setDescription:@"New York"];
	[ny setCategory:@"Business"];
		
	FeedRecord *bb=[[FeedRecord alloc] init];
	[bb setName:@"BBC Entertainment"];	
	[bb setUrl:@"http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml?edition=int"];	
	[bb setDescription:@"BBC Entertainment"];
	[bb setCategory:@"Entertainment"];	
	//build my database	
	feedlist=[[FeedDatabase alloc]init];
	[feedlist addFeed:ya];
	[feedlist addFeed:bbc];
	[feedlist addFeed:ny];
	[feedlist addFeed:bb];	
	
	[ya release];
	[bbc release];
	[ny release];
	[bb release];	
		
	}
	
    [window addSubview:rootController.view];
    
	[window makeKeyAndVisible];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
	/*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
	/*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Saving/Loading

- (NSString *) archiveFilename {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"archivedData"];
	return filename;
}
//save data to the archive
- (void) saveData {
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:feeds forKey:@"feeds"];
	[archiver finishEncoding];
	NSString *filename = [self archiveFilename];
	[data writeToFile:filename atomically:YES];
}

//when you open the application again, it will load the data from here
- (void) loadData {
	
	NSString *filename = [self archiveFilename];
	NSData *data = [[NSData alloc] initWithContentsOfFile:filename];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	
	FeedDatabase *tempfeed = [[FeedDatabase alloc] init];
	tempfeed = [unarchiver decodeObjectForKey:@"feeds"];
	feedlist=[[FeedDatabase alloc]init];
	for(FeedRecord *onefeed in tempfeed.feeds)
			[feedlist addFeed:onefeed];
	for(FeedRecord *oneBookMark in tempfeed.bookmarks)
		[feedlist addBookMarks:oneBookMark];
		
	
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[rootController release];
	[feedlist release];
    [window release];
    [super dealloc];
}


@end
