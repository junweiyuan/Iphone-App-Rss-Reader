//
//  FeedInfoViewController.h
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFeedInfoView.h"

@class FeedDetailViewController;

@interface FeedInfoViewController : UITableViewController  <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *feedsTableView1;
	NSMutableArray *feedsArray1;
	NSString *category2;
	MyFeedInfoView *myFeedInfoView;
	FeedDetailViewController *feedDetailView1;
}

-(void) searchInCategory:(NSString *)category;
@property (nonatomic,retain) NSMutableArray *feedsArray1;
@property (nonatomic,retain) NSString *category2;
@property (nonatomic,retain) MyFeedInfoView *myFeedInfoView;
@property (nonatomic,retain) FeedDetailViewController *feedDetailView1;

@end




