//
//  QiushiImageLatestController.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "QiushiImageLatestController.h"
#import "ImageWithTextCell.h"
#import "Response.h"
#import "FileModel.h"
#import "CommonHelper.h"
#import "AppDelegate.h"

#define kTimelineJson @"http://www.idreems.com/php/embarrasepisode/embarrassing.php?type=image_latest&page=1&count=20"
#define kFileName @"timelinejson"
#define kDestinationName @"Timeline"
#define kDataPath @"data"

#define kTimelineJsonChanged @"kTimelineJsonChanged"

#define kWeiboTimelineResponseDataJson @"data"

@interface QiushiImageLatestController ()

@end

@implementation QiushiImageLatestController
@synthesize fileModel;

#pragma mark - PullTableViewDelegate

- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
{
    [self refreshData];
}

- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
{
    
}

#pragma mark PSCollectionViewDataSource
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    Response *item = [self.items objectAtIndex:index];
    
    // You should probably subclass PSCollectionViewCell
    ImageWithTextCell *v = (ImageWithTextCell *)[self.collectionView dequeueReusableView];
    CGRect rc = CGRectMake(0, 0, kDeviceWidth/self.collectionView.numColsPortrait, KDeviceHeight);
    if(v == nil) {
        v = [[[ImageWithTextCell alloc]initWithFrame:rc]autorelease];
    }
    v.frame = rc;
    v.response = item;
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    return [ImageWithTextCell measureCell:[self.items objectAtIndex:index] width:kDeviceWidth/self.collectionView.numColsPortrait].height;
}

#pragma mark - Methods
-(void)refreshData
{
    //load cache
    NSString* fileDir = [self cacheFile];
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:[self loadContent:fileDir]];
    [self notifyDataChanged];
    
    FileModel* model = [self fileModel];
    [APPDELEGATE beginRequest:model isBeginDown:YES setAllowResumeForFileDownloads:NO];
    
    [[CommonHelper getTargetBookPath:model.destPath] stringByAppendingPathComponent:model.fileName];
}
-(void)loadMoreData
{
    //TODO::more data
    FileModel* model = [self fileModel];
    [APPDELEGATE beginRequest:model isBeginDown:YES setAllowResumeForFileDownloads:NO];
    
    [[CommonHelper getTargetBookPath:model.destPath] stringByAppendingPathComponent:model.fileName];
}
-(FileModel*)fileModel
{
    if(fileModel)
    {
        return fileModel;
    }
    
    fileModel = [[FileModel alloc]init];
    //get data
    
    fileModel.fileURL = kTimelineJson;
    fileModel.fileName = kFileName;
    fileModel.destPath = kDestinationName;
    fileModel.notificationName = kTimelineJsonChanged;
    
    return fileModel;
}
-(NSString*)cacheFile
{
    FileModel* model = [self fileModel];
    
    return [[CommonHelper getTargetBookPath:model.destPath] stringByAppendingPathComponent:model.fileName];
}
-(NSString*)startNetworkRequest
{
    //start request for data
    FileModel* model = [self fileModel];
    [APPDELEGATE beginRequest:model isBeginDown:YES setAllowResumeForFileDownloads:NO];
    
    return [[CommonHelper getTargetBookPath:model.destPath] stringByAppendingPathComponent:model.fileName];
}
-(NSMutableArray*)loadContent:(NSString*)fileName
{
    NSMutableArray  *dataArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    if (data) {
        NSError* error;
        id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (res && [res isKindOfClass:[NSDictionary class]]) {
//            [dataArray removeAllObjects];
            //TODO::add or insert data
            NSArray* arr = [res objectForKey:kWeiboTimelineResponseDataJson];
            for (id item in arr) {
                Response* sts = [Response statusWithJsonDictionary:item];
                [dataArray addObject:sts];
            }
        } else {
            //NSLog(@"arr dataSourceDidError == %@",arrayData);
        }
    }
    return dataArray;
    
}
-(void)didGetTimeLineOnMainThread
{
    [self notifyDataChanged];
}

-(void)didGetTimeLine:(NSNotification*)notification
{
    if(notification)
    {
        if([notification.object isKindOfClass:[NSString class]])
        {
            NSString* fileDir = (NSString*)notification.object;
            if(nil == self.items)
            {
                self.items = [[NSMutableArray alloc]initWithCapacity:0];
            }
            //TODO::add or insert data
//            [self.items removeAllObjects];
            [self.items addObjectsFromArray:[self loadContent:fileDir]];
        }
        else if([notification.object isKindOfClass:[NSError class]])//error
        {
            //fail to load data
            [self notifyDataChanged];
        }
    }
    
    
    [self performSelectorOnMainThread:@selector(didGetTimeLineOnMainThread) withObject:nil waitUntilDone:TRUE];
}

#pragma mark view lifecircle
-(void)back
{
    [self dismissModalViewControllerAnimated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = backButton;
    [backButton release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetTimeLine:)    name:kTimelineJsonChanged          object:nil];
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    self.fileModel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end