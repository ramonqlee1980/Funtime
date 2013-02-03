//
//  UITableViewCellResponse.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  Response;

@interface UITableViewCellResponse : UITableViewCell
{
    Response* response;
    UILabel* label;
    UIImageView* imageView;
}
@property(nonatomic,retain)Response* response;
@property(nonatomic,assign)UILabel* label;
@property(nonatomic,assign)UIImageView* imageView;

+(CGSize)measureCell:(Response*)status;
@end
