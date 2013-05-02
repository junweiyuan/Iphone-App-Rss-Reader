//
//  FeedDetailViewController.h
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeedDetailViewController : UIViewController <UIActionSheetDelegate>{
	UITextField *nameField;
	UITextField *urlField;
	UITextField *categoryField;
	UITextField *descriptionField;
	NSString *name1;
	

}
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *urlField;
@property (nonatomic, retain) IBOutlet UITextField *categoryField;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;
@property (nonatomic, retain) NSString *name1;


-(IBAction) keyboardHide;
-(IBAction) saveButton;



@end
