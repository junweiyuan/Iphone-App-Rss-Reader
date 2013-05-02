//
//  FeedRecord.m
//  Final_Project
//
//  Created by Student on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedRecord.h"


@implementation FeedRecord

NSString *_name;
NSString *_url;
NSString *_category;
NSString *_description;

@synthesize name = _name;
@synthesize url = _url;
@synthesize category = _category;
@synthesize description = _description;

- (id)init
{
	self = [super init];
	if(self) {
		/* Set initial values */
		_name = @"";
		_url = @"";
		_category = @"";
		_description = @"";

	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		
		self.name = [decoder decodeObjectForKey:@"name"];
		self.url = [decoder decodeObjectForKey:@"url"];
		self.category	= [decoder decodeObjectForKey:@"category"];
		self.description = [decoder decodeObjectForKey:@"description"];
	}
	return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.url forKey:@"url"];
	[encoder encodeObject:self.category forKey:@"category"];
	[encoder encodeObject:self.description forKey:@"description"];
}



#pragma mark Memory Management
- (void)dealloc
{
	self.name = nil;
	self.url = nil;
	self.category = nil;
	self.description = nil;
	
	[super dealloc];
}
@end



