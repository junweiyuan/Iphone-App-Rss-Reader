//
//  NewsWebViewController.h
//  Final_Project
//
//  Created by Student on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsWebViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	NSString *link;
	IBOutlet UIActivityIndicatorView *activityIndicator;

}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) NSString *link1;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
