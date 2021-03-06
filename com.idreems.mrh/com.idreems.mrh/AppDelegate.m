//
//  AppDelegate.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 12/29/12.
//  Copyright (c) 2012 ramonqlee. All rights reserved.
//

#import "AppDelegate.h"

#import "FileModel.h"
#import "CommonHelper.h"
#import "ViewController.h"
#import "Flurry.h"
#import "AboutViewController.h"
#import "iRate.h"
#import "AdsConfig.h"

#import "MainZakerViewController.h"
#import <ShareSDK/ShareSDK.h>

#define kMaxConcurrentOperationCount 1

#define kUpdateApp 0
#define kOpenWeixin 1

#define kLaunchTime @"kLaunchTime"
#define kRatingWhenLaunchTime 5

@implementation AppDelegate
@synthesize downinglist;
@synthesize finishedlist;

#pragma mark var allocate&dealloc

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
#if 1
	[iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    [iRate sharedInstance].appStoreID = [kAppIdOnAppstore integerValue];
    
    [AppDelegate logLaunch];
    //enable preview mode
    [iRate sharedInstance].previewMode = [AppDelegate shouldPromptRating];
#endif
}
+(BOOL)shouldPromptRating
{
    NSUserDefaults* defaultSetting = [NSUserDefaults standardUserDefaults];
    NSString* switchVal = [defaultSetting stringForKey:kLaunchTime];
    return (switchVal!=nil && (switchVal.integerValue == kRatingWhenLaunchTime));
}
+(void)logLaunch
{
    NSUserDefaults* defaultSetting = [NSUserDefaults standardUserDefaults];
    NSString* switchVal = [defaultSetting stringForKey:kLaunchTime];
    NSInteger count = 0;
    if(switchVal)
    {
        count = switchVal.integerValue;
    }
    if(count<=kRatingWhenLaunchTime)
    {
        [defaultSetting setValue:[NSString stringWithFormat:@"%d",++count] forKey:kLaunchTime];
    }
}
-(id)init
{
    if(!mOperationQueue)
    {
        mOperationQueue = [[NSOperationQueue alloc]init];
        [mOperationQueue setMaxConcurrentOperationCount:kMaxConcurrentOperationCount];//serial operation
    }
    if(!finishedlist)
    {
        finishedlist = [[NSMutableArray alloc]init];
    }
    if(!downinglist)
    {
        downinglist = [[NSMutableArray alloc]init];
    }
    return [super init];
}

#pragma mark application Event
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [ShareSDK registerApp:kShareSDKAppId];
    
    UIViewController* zakerCtrl = [[MainZakerViewController alloc]init];
    self.window.rootViewController = zakerCtrl;
    [zakerCtrl release];
    
    [self.window makeKeyAndVisible];
    
    //flurry
    [Flurry startSession:kFlurryID];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */
- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [downinglist release];
    [finishedlist release];
    [mOperationQueue release];
    [super dealloc];
}

#pragma mark HTTPRequest
-(void)beginRequest:(FileModel *)fileInfo isBeginDown:(BOOL)isBeginDown setAllowResumeForFileDownloads:(BOOL)allow
{
    //如果不存在则创建临时存储目录
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[CommonHelper getTempFolderPath]])
    {
        [fileManager createDirectoryAtPath:[CommonHelper getTempFolderPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    //按照获取的文件名获取临时文件的大小，即已下载的大小
    fileInfo.isFistReceived=YES;
    NSData *fileData=[fileManager contentsAtPath:[[CommonHelper getTempFolderPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",fileInfo.fileName]]];
    NSInteger receivedDataLength=[fileData length];
    fileInfo.fileReceivedSize=[NSString stringWithFormat:@"%d",receivedDataLength];
    //url encoding
    NSString* fileURL = ([fileInfo.fileURL rangeOfString:@"%"].length==0)?[fileInfo.fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:fileInfo.fileURL;
    //如果文件重复下载或暂停、继续，则把队列中的请求删除，重新添加
    for(ASIHTTPRequest *tempRequest in self.downinglist)
    {
        FileModel *f =(FileModel *)[tempRequest.userInfo objectForKey:@"File"];
        NSString* url = ([f.fileURL rangeOfString:@"%"].length==0)?[f.fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:f.fileURL;
        if([url isEqual:fileURL])
        {
            [tempRequest cancel];
            [downinglist removeObject:tempRequest];
            break;
        }
    }
    
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fileURL]];
    request.delegate=self;
    [request setDownloadDestinationPath:[[CommonHelper getTargetFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileInfo.fileName]]];
    [request setTemporaryFileDownloadPath:[[CommonHelper getTempFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",fileInfo.fileName]]];
    [request setDownloadProgressDelegate:self];
    //    [request setDownloadProgressDelegate:downCell.progress];//设置进度条的代理,这里由于下载是在AppDelegate里进行的全局下载，所以没有使用自带的进度条委托，这里自己设置了一个委托，用于更新UI
    [request setAllowResumeForFileDownloads:allow];//支持断点续传
    if(isBeginDown)
    {
        fileInfo.isDownloading=YES;
    }
    else
    {
        fileInfo.isDownloading=NO;
    }
    [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];//设置上下文的文件基本信息
    [request setTimeOutSeconds:30.0f];
    if (isBeginDown) {
        [request startAsynchronous];
    }
    
    //    [downinglist addObject:request];
    
    [request release];
}
-(void)beginRequest:(FileModel *)fileInfo isBeginDown:(BOOL)isBeginDown
{
    [self beginRequest:fileInfo isBeginDown:isBeginDown setAllowResumeForFileDownloads:YES];
}
#pragma mark ASIHttpRequestDelegate

//出错了，如果是等待超时，则继续下载
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error=[request error];
    NSLog(@"ASIHttpRequest出错了!%@",error);
    FileModel *fileModel=[request.userInfo objectForKey:@"File"];
    if(fileModel && fileModel.notificationName && fileModel.notificationName.length)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:fileModel.notificationName object:error];
    }
}

-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"开始了!");
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    if(fileInfo)
    {
        fileInfo.fileType=[[request responseHeaders] objectForKey:@"Content-Type"];
        fileInfo.fileSize=[CommonHelper getFileSizeString:[[request responseHeaders] objectForKey:@"Content-Length"]];
        NSLog(@"收到回复了！contentType:%@--fileSize:%@",fileInfo.fileType,fileInfo.fileSize);
        
        //文件开始下载时，把文件名、文件总大小、文件URL写入文件，上海滩.rtf中间用逗号隔开
        /*NSString *writeMsg=[fileInfo.fileName stringByAppendingFormat:@",%@,%@",fileInfo.fileSize,fileInfo.fileURL];
         NSRange range = [fileInfo.fileName rangeOfString:@"."];
         NSString *name=(range.length==0)?fileInfo.fileName:[fileInfo.fileName substringToIndex:range.location];
         [writeMsg writeToFile:[[CommonHelper getTempFolderPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.rtf",name]] atomically:YES encoding:NSUTF8StringEncoding error:nil];*/
        
        [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];//设置上下文的文件基本信息
        
    }
}


//1.实现ASIProgressDelegate委托，在此实现UI的进度条更新,这个方法必须要在设置[request setDownloadProgressDelegate:self];之后才会运行
//2.这里注意第一次返回的bytes是已经下载的长度，以后便是每次请求数据的大小
//费了好大劲才发现的，各位新手请注意此处
-(void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    if(fileInfo && !fileInfo.isFistReceived)
    {
        fileInfo.fileReceivedSize=[NSString stringWithFormat:@"%lld",[fileInfo.fileReceivedSize longLongValue]+bytes];
    }
    fileInfo.isFistReceived=NO;
}

//将正在下载的文件请求ASIHttpRequest从队列里移除，并将其配置文件删除掉,然后向已下载列表里添加该文件对象
-(void)requestFinished:(ASIHTTPRequest *)request
{
    const NSUInteger kHTTPOK =  200;
    //[self playDownloadFinishSound];
    FileModel *fileInfo=(FileModel *)[request.userInfo objectForKey:@"File"];
    NSLog(@"fileInfo refCount:%d",[fileInfo retainCount]);
    fileInfo.fileType = [[request responseHeaders] objectForKey:@"Content-Type"];
    
    NSRange range=[fileInfo.fileName rangeOfString:@"."];
    NSString *name=(range.length==0)?fileInfo.fileName:[fileInfo.fileName substringToIndex:range.location];
    if (!fileInfo.destPath) {
        fileInfo.destPath = name;
    }
    NSString *configPath=[[CommonHelper getTempFolderPath] stringByAppendingPathComponent:[name stringByAppendingString:@".rtf"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    
    if([fileManager fileExistsAtPath:configPath])//如果存在临时文件的配置文件
    {
        [fileManager removeItemAtPath:configPath error:&error];
    }
    if(!error)
    {
        NSLog(@"%@",[error description]);
    }
    if(kHTTPOK != request.responseStatusCode)
    {
        //pop up a tip only
        //[[NSNotificationCenter defaultCenter]postNotificationName:kFileDownloadFail object:fileInfo];
    }
    else
    {
        //add to operation queue
        NSInvocationOperation* operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(saveDownloadedResources:) object:fileInfo];
        [mOperationQueue addOperation:operation];
        [operation release];
        
        
        [finishedlist addObject:fileInfo];
        [downinglist removeObject:request];
        [downinglist removeObject:request];
        
    }
}

#pragma mark after-download
-(void)saveDownloadedResources:(FileModel*)fileModel
{
    NSLog(@"saveDownloadedResources:%@",fileModel.fileName);
    
    NSString *documentsDirectory = [CommonHelper getTargetFolderPath];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:fileModel.fileName];
    NSFileManager* fileManager =[NSFileManager defaultManager];
    NSRange range=[fileModel.fileName rangeOfString:@"."];
    NSString *name=(range.length==0)?fileModel.fileName:[fileModel.fileName substringToIndex:range.location];
    if (!fileModel.destPath) {
        fileModel.destPath = name;
    }
    
    //unzip(zip,rar,txt)
    NSString* desFilePath = [CommonHelper getTargetBookPath:fileModel.destPath];
    [CommonHelper extractFile:fileName toFile:[CommonHelper getTargetBookPath:fileModel.destPath] fileType:fileModel.fileType];
    
    [fileManager removeItemAtPath:fileName error:nil];
    
    if(fileModel.notificationName && fileModel.notificationName.length)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:fileModel.notificationName object:[desFilePath stringByAppendingPathComponent:fileModel.fileName]];
    }
}
#pragma ShareSDK delegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url wxDelegate:self]; }

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [ShareSDK handleOpenURL:url wxDelegate:self]; }

@end
