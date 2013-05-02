//
//  BookMarksViewController.h
//  Final_Project
//
//  Created by Student on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsWebViewController;

@interface BookMarksViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView * bookmarksTable;
	NSMutableArray *bookmarkArray;
	
}

@property (nonatomic,retain) NSMutableArray *bookmarkArray;
@property (nonatomic,retain) NewsWebViewController *newsWebView;

@end
