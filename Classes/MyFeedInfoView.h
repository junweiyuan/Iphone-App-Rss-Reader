//
//  MyFeedInfoView.h
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface MyFeedInfoView : UIViewController <UIActionSheetDelegate> {
	
	UITextField *nameField;
	UITextField *urlField;
	UITextField *categoryField;
	UITextField *descriptionField;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *urlField;

@property (nonatomic, retain) IBOutlet UITextField *categoryField;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;

-(IBAction) keyboardHide;
-(IBAction) cancelButton;
-(IBAction) saveButton;
- (void) actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger) buttonIndex;

@end
