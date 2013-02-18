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

-(BOOL)isEqual:(id)object
{
    if(!object)
    {
        return NO;
    }
    Response* cmp = (Response*)object;
    if(0==[self.description length])
    {
        return [self.thumbnailUrl isEqualToString:cmp.thumbnailUrl];
    }
    else
    {
        return [self.description isEqualToString:cmp.description];
    }
}
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
