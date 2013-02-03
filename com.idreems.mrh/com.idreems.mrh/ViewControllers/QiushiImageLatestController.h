//
//  QiushiImageLatestController.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "CollectionViewController.h"
@class FileModel;
@interface QiushiImageLatestController : CollectionViewController
{
    FileModel* fileModel;
}
@property(nonatomic,retain) FileModel* fileModel;
@end
