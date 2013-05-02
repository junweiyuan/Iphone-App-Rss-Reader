//
//  searchViewController.m
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@class NewsDetail;

@interface RootViewController : UITableViewController <NSXMLParserDelegate>{
	
	IBOutlet UITableView * newsTable;
	IBOutlet UIActivityIndicatorView * activityIndicator;
	
	//CGSize cellSize;
	NSXMLParser * rssParser;
	NewsDetail *newsDetail;
	NSMutableArray * stories;
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
	NSMutableString * currentImage;
	UIToolbar * _toolbar;
	NSString * feedName1;
}

@property (nonatomic,retain) NewsDetail *newsDetail;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView * activityIndicator;



@property (nonatomic,retain) NSString *feedName1;
- (void)parseXMLFileAtURL:(NSString *)URL;
-(void) searchInFeed:(NSString *)feedName;

@end
