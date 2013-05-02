//
//  NewsDetail.h
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Final_ProjectAppDelegate;

@interface NewsDetail : UIViewController <UIActionSheetDelegate> {
	Final_ProjectAppDelegate *appDelegate;
	NewsDetail *news;
	UITextView *titleTextView;
	UITextView *descriptionTextView;
	UIToolbar *toolbar;
	UIImageView *_image;
	NSString *title1;
    NSString *description1;
	NSString *medialink1;

}



@property (nonatomic,retain) IBOutlet  UITextView *titleTextView;
@property (nonatomic,retain) IBOutlet  UITextView *descriptionTextView;
@property (nonatomic,retain) IBOutlet  UIToolbar *toolbar;
@property (nonatomic,retain) IBOutlet  UIImageView *image;
@property (nonatomic,retain) NSString *title1;
@property (nonatomic,retain) NSString *description1;
@property (nonatomic,retain) NSString *link1;
@property (nonatomic,retain) NSString *medialink1;
@property (nonatomic,retain) NewsDetail *news;

@end
