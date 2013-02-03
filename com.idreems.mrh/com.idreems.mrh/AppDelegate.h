//
//  AppDelegate.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 12/29/12.
//  Copyright (c) 2012 ramonqlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@class FileModel;

#define APPDELEGATE    (AppDelegate*)[[UIApplication sharedApplication]delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,WXApiDelegate>
{
    NSOperationQueue* mOperationQueue;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property(nonatomic,retain)NSMutableArray *finishedlist;//已下载完成的文件列表（文件对象）

@property(nonatomic,retain)NSMutableArray *downinglist;//正在下载的文件列表(ASIHttpRequest对象)

-(void)beginRequest:(FileModel *)fileInfo isBeginDown:(BOOL)isBeginDown setAllowResumeForFileDownloads:(BOOL)allow;
-(void)beginRequest:(FileModel *)fileInfo isBeginDown:(BOOL)isBeginDown;
@end
