//
//  MyViewController.h
//  Final_Project
//
//  Created by Student on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyViewController : UIViewController <UIActionSheetDelegate> {


	UITextField *categoryField;
	UITextField *descriptionField;
}



@property (nonatomic, retain) IBOutlet UITextField *categoryField;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;

-(IBAction) keyboardHide;
-(IBAction) cancelButton;
-(IBAction) saveButton;
- (void) actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger) buttonIndex;

@end
