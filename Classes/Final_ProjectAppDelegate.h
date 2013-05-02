//
//  Final_ProjectAppDelegate.h
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedDatabase.h"
#import "FeedRecord.h"

@class AccelerometerViewController;
@class TableViewCell;
@class ViewController;
@class BrowseViewController;

@interface Final_ProjectAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	//I set the tabbar as the rootview
	IBOutlet UITabBarController *rootController;
	FeedDatabase *feedlist;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain) FeedDatabase *feedlist;


- (NSString *) archiveFilename;
- (void) saveData;
- (void) loadData;


@end



