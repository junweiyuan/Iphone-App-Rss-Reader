//
//  FeedDatebase.m
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedDatabase.h"
#import "Final_ProjectAppDelegate.h"

@implementation FeedDatabase

@synthesize feeds=_feeds;
@synthesize bookmarks=_bookmarks;
@synthesize read=_read;
#pragma mark -
#pragma mark Setup
- (id)init
{
	self = [super init];
	if(self) {
		_feeds = [[NSMutableArray alloc] init];
		_bookmarks=[[NSMutableArray alloc] init];
		_read=[[NSMutableArray alloc] init];
	}
	return self;
}


- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		_feeds = [decoder decodeObjectForKey:@"feeds"];
		_bookmarks=[decoder decodeObjectForKey:@"bookmarks"];
		
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.feeds forKey:@"feeds"];
	[encoder encodeObject:self.bookmarks forKey:@"bookmarks"];
	
	
}


#pragma mark Accessors
/* Returns the number of feeds in the database */

- (NSUInteger)numFeeds
{
	return [self.feeds count];
}

-(NSUInteger)numBookMarks
{
	return [self.bookmarks count];
}

-(NSUInteger)numread
{
	return [self.read count];
}

- (FeedRecord *)getFeedAtIndex:(NSUInteger)index
{
	/* Make sure the index is valid */
	if(index < 0 || index >= [self numFeeds]) {
		return NULL;
	}
	
	
	/* Return the contact */
	return [self.feeds objectAtIndex:index];
}

- (FeedRecord *)getBookMarksAtIndex:(NSUInteger)index
{
	/* Make sure the index is valid */
	if(index < 0 || index >= [self numBookMarks]) {
		return NULL;
	}
	
	
	/* Return the contact */
	return [self.bookmarks objectAtIndex:index];
}

-(NSUInteger)getReadAtIndex:(NSUInteger)index
{
	return [[self.read objectAtIndex:index]intValue];
}

#pragma mark Add
/* Adds the specified contact to the end of the database */
- (void)addFeed:(FeedRecord *)feed 
{
	[self.feeds addObject:feed];
}

-(void) addBookMarks:(FeedRecord *)feed
{
	[self.bookmarks addObject:feed];
}

- (void) addRead:(NSUInteger)read
{
	NSNumber *number = [NSNumber numberWithInt:0];

	[self.read insertObject:number atIndex:[self.read count]];
}

- (FeedRecord *)removeFeedAtIndex:(NSUInteger)index
{
	
	/* Get the contact to remove */
	FeedRecord *doomedRecord = [self getFeedAtIndex:index];
	
	/* If there actually was a contact at that index, remove it */
	if(doomedRecord) {
		[self.feeds removeObjectAtIndex:index];
	}
	
	
	/* Return the contact */
	return doomedRecord;
}

- (FeedRecord *)removeBookMarksAtIndex:(NSUInteger)index
{
	
	/* Get the contact to remove */
	FeedRecord *doomedRecord = [self getBookMarksAtIndex:index];
	
	/* If there actually was a contact at that index, remove it */
	if(doomedRecord) {
		[self.bookmarks removeObjectAtIndex:index];
	}
	
	
	/* Return the contact */
	return doomedRecord;
}

// loading the prevfeed into the app
-(void) addPrevFeeds:(FeedDatabase *) tempFeed{
	Final_ProjectAppDelegate* appDelegate = (Final_ProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	FeedDatabase *feeds = appDelegate.feedlist;
	for(FeedRecord *temp in tempFeed.feeds)
		[feeds addFeed:temp];
	for (FeedRecord *temp in tempFeed.bookmarks)
		[feeds addBookMarks:temp];
		
	
}




#pragma mark Memory Management
- (void)dealloc
{
	[_bookmarks release];
	[_feeds release];
	[super dealloc];
}




@end
