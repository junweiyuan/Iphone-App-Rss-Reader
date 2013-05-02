//
//  searchViewController.h
//  Final_Project
//
//  Created by Student on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface searchViewController : UIViewController {
	IBOutlet UIWebView *webView;
	BOOL isHidden;

	
}
@property (nonatomic,retain) UIWebView *webView;


@end
