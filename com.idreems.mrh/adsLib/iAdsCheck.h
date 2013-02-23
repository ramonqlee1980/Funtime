//
//  iAdsCheck.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/23/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iAdsCheck : NSObject
{
    UIViewController* _viewController;
}
@property (nonatomic, assign) UIViewController* viewController;
+ (iAdsCheck *)sharedInstance;
-(void)start:(NSObject*)delegate;
@end
