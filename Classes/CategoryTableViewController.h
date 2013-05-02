//
//  CategoryTableViewController.h
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//class reference
@class Feed;

@interface CategoryTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *categoryTableView;
	NSMutableArray *categoryArray;
	Feed *feedViewController;
}
@property (nonatomic,retain) NSMutableArray *categoryArray;
@property (nonatomic,retain) Feed *feedViewController;

@end
