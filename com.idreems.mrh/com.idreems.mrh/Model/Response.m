//
//  Response.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "Response.h"
#import "NSDictionaryAdditions.h"

@implementation Response
@synthesize description;
@synthesize thumbnailUrl;
@synthesize largeUrl;

- (Response*)initWithJsonDictionary:(NSDictionary*)dict
{
    if (self = [super init]) {
		self.description = [dict getStringValueForKey:@"description" defaultValue:@""];
        self.thumbnailUrl = [dict getStringValueForKey:@"thumbnailUrl" defaultValue:@""];
        self.largeUrl = [dict getStringValueForKey:@"largeUrl" defaultValue:@""];
    }
    return self;
}

+ (Response*)statusWithJsonDictionary:(NSDictionary*)dict
{
    return [[[Response alloc]initWithJsonDictionary:dict]autorelease];
}


-(void)dealloc
{
    self.description = nil;
    self.thumbnailUrl = nil;
    self.largeUrl = nil;
    [super dealloc];
}
@end
