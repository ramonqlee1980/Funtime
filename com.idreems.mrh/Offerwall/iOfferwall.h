//
//  iOfferwall.h
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/23/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iOfferwall : NSObject
{
    UIViewController* _viewController;
}
@property (nonatomic, assign) UIViewController* viewController;

+ (iOfferwall *)sharedInstance;
-(void)open:(NSArray*)wallName;
-(void)close:(NSArray*)wallName;

@end
