//
//  ImageWithTextCell.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "PSCollectionViewCell.h"
@class Response;
@interface ImageWithTextCell : PSCollectionViewCell
{
    Response* response;
    UIImageView* centerimageView;
    UILabel* label;
    UIImageView* footerView;
    UIImageView* imageView;
}
@property(nonatomic,retain)Response* response;
@property(nonatomic,assign)UIImageView* centerimageView;
@property(nonatomic,assign)UILabel* label;
@property(nonatomic,assign)UIImageView* imageView;
@property(nonatomic,assign)UIImageView* footerView;

+(CGSize)measureCell:(Response*)status width:(CGFloat)width;
@end
