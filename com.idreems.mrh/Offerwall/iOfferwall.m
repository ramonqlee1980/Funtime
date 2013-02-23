//
//  iOfferwall.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/23/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "iOfferwall.h"

@implementation iOfferwall
@synthesize viewController=_viewController;

+ (iOfferwall *)sharedInstance
{
    static iOfferwall *sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[iOfferwall alloc] init];
    }
    return sharedInstance;
}
-(void)open:(NSArray*)wallName
{
    
}
-(void)close:(NSArray*)wallName
{
    
}
@end
