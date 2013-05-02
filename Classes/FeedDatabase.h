//
//  FeedDatebase.h
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedRecord.h"



@interface FeedDatabase : NSObject {
	NSMutableArray *_feeds;
	NSMutableArray *_bookmarks;
	NSMutableArray *_read;
}

@property (readonly) NSMutableArray *feeds;
@property (readonly) NSMutableArray *bookmarks;
@property (readonly) NSMutableArray *read;

- (NSUInteger)numFeeds;
- (NSUInteger)numBookMarks;
- (NSUInteger)numread;

- (FeedRecord *)getFeedAtIndex:(NSUInteger)index;
- (FeedRecord *)getBookMarksAtIndex:(NSUInteger)index;
- (NSUInteger )getReadAtIndex:(NSUInteger)index;

- (void) addFeed:(FeedRecord *)feed;
- (void) addBookMarks:(FeedRecord *)feed;
- (void) addRead:(NSUInteger)read;


- (FeedRecord *)removeFeedAtIndex:(NSUInteger)index;
- (FeedRecord *)removeFeedAtIndex:(NSUInteger)index;


- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;
-(void) addPrevBookMarks:(FeedDatabase *) tempFeed;

@end
