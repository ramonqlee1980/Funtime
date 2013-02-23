//
//  iAdsCheck.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/23/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "iAdsCheck.h"
#import "FileModel.h"
#import "AdsConfig.h"
#import "iOfferwallManager.h"
#import "CommonHelper.h"

@implementation iAdsCheck
@synthesize viewController=_viewController;
+ (iAdsCheck *)sharedInstance
{
    static iAdsCheck *sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[iAdsCheck alloc] init];
    }
    return sharedInstance;
}
-(void)start:(NSObject*)delegate
{
    FileModel* model = [[[FileModel alloc]init]autorelease];
    model.fileName = kDefaultAds;
    model.destPath = kDefaultAdsDir;
    
    model.fileURL = AdsUrl;
    model.notificationName = kAdsConfigNotification;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetAdsConfig:)    name:model.notificationName          object:nil];
    if ([delegate respondsToSelector:@selector(beginRequest:isBeginDown:setAllowResumeForFileDownloads:)]) {
        [CommonHelper performSelector:delegate selector:@selector(beginRequest:isBeginDown:setAllowResumeForFileDownloads:) withObject:model withObject:YES withObject:NO];
    }
}
-(void)didGetAdsConfig:(NSNotification*)notification
{
    if(notification)
    {
        if([notification.object isKindOfClass:[NSString class]])
        {
            [self performSelector:@selector(performOnMainThread:) onThread:[NSThread mainThread] withObject:notification waitUntilDone:YES];            
            
        }
        else if([notification.object isKindOfClass:[NSError class]])//error
        {
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAdsConfigNotification object:nil];
}
-(void)performOnMainThread:(NSNotification*)notification
{
    NSString* fileName = (NSString*)notification.object;
    //load ads config
    [AdsConfig reset];
    AdsConfig* config = [AdsConfig sharedAdsConfig];
    [config init:fileName];
    if([config wallShouldShow])
    {
        iOfferwallManager* mgr = [iOfferwallManager sharedInstance];
        mgr.viewController = self.viewController;
        [mgr open:[config getAdsWalls]];
    }
}
@end
