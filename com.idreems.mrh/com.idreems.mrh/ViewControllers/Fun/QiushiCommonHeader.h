//
//  QiushiCommonHeader.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 1/15/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LastestURLString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/latest?count=%d&page=%d",count,page]
#define ImageURLString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/images?count=%d&page=%d",count,page]
#define SuggestURLString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/suggest?count=%d&page=%d",count,page]
#define DayURLString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/day?count=%d&page=%d",count,page]
#define WeakURlString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/week?count=%d&page=%d",count,page]
#define MonthURLString(count,page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/month?count=%d&page=%d",count,page]
#define CommentsURLString(ID) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?count=500&page=1",ID]

#define ClearRequest(request) if(request!=nil){[request clearDelegatesAndCancel];[request release];request=nil;}

#define LoginURLString(userName,passWord) [NSString stringWithFormat:@"m2.qiushibaike.com/user/signin?loginName=%@&password=%@",userName,passWord]

typedef enum
{
    QiuShiTypeTop,
    QiuShiTypeNew,
    QiuShiTypePhoto,
    
}QiuShiType;

typedef enum
{
    QiuShiTimeDay,
    QiuShiTimeWeek,
    QiuShiTimeMonth,
    QiuShiTimeRandom,
    
}QiuShiTime;
