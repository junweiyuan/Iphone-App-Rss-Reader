//
//  AboutViewController.h
//  Final_Project
//
//  Created by Student on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactMe.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>



@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	ContactMe *contactView;
}
@property (nonatomic,retain) ContactMe *contactView;
- (IBAction)contactAction:(id)sender;
-(IBAction)showPicker:(id)sender;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;


@end
