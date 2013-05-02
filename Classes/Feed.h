//
//  Feed.h
//  Final_Project
//
//  Created by Student on 3/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;



@interface Feed : UITableViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *feedsTableView;
	NSMutableArray *feedsArray;
	RootViewController *rootViewController;
	NSString *category1;//to save what chosen from the CategoryTableViewController
}

-(void) searchInCategory:(NSString *)category;
@property (nonatomic,retain) NSMutableArray *feedsArray;
@property (nonatomic,retain) RootViewController *rootViewController;
@property (nonatomic,retain) NSString *category1;
@end
