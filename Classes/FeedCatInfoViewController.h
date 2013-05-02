//
//  FeedCatInfoViewController.h
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyViewController.h"

@class FeedInfoViewController;

@interface FeedCatInfoViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource> {
		
		IBOutlet UITableView *categoryTableView1;
		NSMutableArray *categoryArray;
		FeedInfoViewController *feedViewController1;
		MyViewController *myViewController;
	}
@property (nonatomic,retain) NSMutableArray *categoryArray;
@property (nonatomic,retain) FeedInfoViewController *feedViewController1;
@property (nonatomic, retain) MyViewController *myViewController;
	
@end
