//
//  FeedRecord.h
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FeedRecord : NSObject {
	NSString *_name;
	NSString *_url;
	NSString *_category;
	NSString *_description;

}

@property (readwrite,retain) NSString *name;
@property (readwrite,retain) NSString *url;
@property (readwrite,retain) NSString *category;
@property (readwrite,retain) NSString *description;

- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;

@end
