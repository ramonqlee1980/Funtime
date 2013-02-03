//
//  AdsConfig.h
//  HappyLife
//
//  Created by ramon lee on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//appstore switch
#define k91Appstore
#define __IN_APP_SUPPORT__

//ads url
#define kDefaultAds @"defaultAds"

#ifdef k91Appstore
#define AdsUrl @"http://www.idreems.com/example.php?adsconfigNonAppstore.xml"
#else
#define AdsUrl @"http://www.idreems.com/example.php?adsconfig20.xml"
#endif

#define kInAppPurchaseProductName @"com.idreems.maketoast.inapp"
//code macro
#define kSingleFile
#define kWixinChatID @"wx906a8a63865c9a7f"

#define kFlurryID @"D5WYXYC4R9C6273W7M9Q"
//weibo key and secret
//sina weibo
#define kOAuthConsumerKey				@"319938111"		//REPLACE ME
#define kOAuthConsumerSecret			@"1618d139b2ea94d0ddb5ef931245265a"		//REPLACE ME

//appid
#define kAppIdOnAppstore @"471656942"

//etmob
#define kEtmobeAppToken @"486c74d7-efad-460d-9f5f-ffcaef50ed11"
//wall
//修改为你自己的AppID和AppSecret
#define kDefaultAppID_iOS           @"6b875a1db75ff9e5" // youmi default app id
#define kDefaultAppSecret_iOS       @"e6983e250159ac64" // youmi default app secret


//id for ads
#define kMobiSageID_iPhone  @"e270159b22cc4c98a64e4402db48e96d"
#define kMobiSageIDOther_iPhone  @"242f601007b249fa8a2577890e80e217"
#define kWiyunID_iPhone  @"84f03bdec273a137"
#define kWiyunID_iPad    @"29ae6d7c8172f013"
#define kWoobooPublisherID  @"3126e9a7c08e452090ff8fa179495797"
#define kDomobPubliserID @"56OJyOqouMF2HGNhFr"
#define kCaseeIPhoneId         @"4FB83ED3982EC730A8490A7BCAEDBAF0"
#define kCaseeIPadId @"D2C1D2621157FA73F29875AF3875AF4D"
#define kYoumiId kDefaultAppID_iOS
#define kYoumiSecret kDefaultAppSecret_iOS
#define kAdmobID @"a14f1b56e4ba533"
#define kWapsId @"5a3029e17a29d1f8d8fb764318406970"
//default etmob apptoken
#ifndef kEtmobeAppToken
#define kEtmobeAppToken @"0fade664-5374-42d8-8488-d505b5c11dcc"
#endif

#define kImmobBannerId @"25d37c3d48c33556e68fcd9ceb1fdd67"
#define kImmobWallId @"69b92a0f35cd484d4d93de787397b7d9"


//ads platform names
#define AdsPlatformWooboo @"Wooboo"
#define AdsPlatformWiyun @"Wiyun"
#define AdsPlatformMobisage @"Mobisage"
#define AdsPlatformMobisageOther @"MobisageOther"
#define AdsPlatformDomob @"Domob"
#define AdsPlatformYoumi @"Youmi"//not implemented right now
#define AdsPlatformCasee @"Casee"
#define AdsPlatformAdmob @"Admob"
#define AdsPlatformMobisageRecommend @"MobisageRecommend"
#define AdsPlatformMobisageRecommendOther @"MobisageRecommendOther"
#define AdsPlatformWQMobile @"WQMobile"
#define AdsPlatformImmob @"Immob"
#define AdsPlatformMiidi @"miidi"
#define AdsPlatformWaps @"waps"

//ads wall
#define AdsPlatformImmobWall @"ImmobWall"
#define AdsPlatformYoumiWall @"YoumiWall"
#define AdsPlatformWapsWall @"WapsWall"
#define AdsPlatformMobisageWall @"MobisageWall"
#define AdsPlatformEtmobWall @"EtmobWall"
#define AdsPlatformDefaultWall AdsPlatformYoumiWall

#define kETmobUrl @"http://etmob.etonenet.com/"



#define kNewContentScale 5
#define kMinNewContentCount 3

#define kWeiboMaxLength 140
#define kAdsSwitch @"AdsSwitch"
#define kPermanent @"Permanent"
#define kDateFormatter @"yyyy-MM-dd"

//for notification
#define kAdsUpdateDidFinishLoading @"AdsUpdateDidFinishLoading"
#define  kUpdateTableView @"UpdateTableView"

#define kOneDay (24*60*60)
#define kTrialDays  1

//flurry event
#define kFlurryRemoveTempConfirm @"kRemoveTempConfirm"
#define kFlurryRemoveTempCancel  @"kRemoveTempCancel"
#define kEnterMainViewList       @"kEnterMainViewList"
#define kFlurryOpenRemoveAdsList @"kOpenRemoveAdsList"

#define kFlurryDidSelectApp2RemoveAds @"kDidSelectApp2RemoveAds"
#define kFlurryRemoveAdsSuccessfully  @"kRemoveAdsSuccessfully"
#define kDidShowFeaturedAppNoCredit   @"kDidShowFeaturedAppNoCredit"

#define kShareByWeibo @"kShareByWeibo"
#define kShareByEmail @"kShareByEmail"

#define kEnterBylocalNotification @"kEnterBylocalNotification"
#define kDidShowFeaturedAppCredit @"kDidShowFeaturedAppCredit"

#define kFlurryDidSelectAppFromRecommend @"kFlurryDidSelectAppFromRecommend"
#define kFlurryDidSelectAppFromMainList  @"kFlurryDidSelectAppFromMainList"
#define kFlurryDidReviewContentFromMainList  @"kFlurryDidReviewContentFromMainList"
#define kLoadRecommendAdsWall @"kLoadRecommendAdsWall"
//favorite
#define kEnterNewFavorite @"kEnterNewFavorite"
#define kOpenExistFavorite @"kOpenExistFavorite"
#define kQiushiReviewed @"kQiushiReviewed"
#define kQiushiRefreshed @"kQiushiRefreshed"

//weixin
#define kFlurryConfirmOpenWeixinInAppstore @"kConfirmOpenWeixinInAppstore"
#define kFlurryCancelOpenWeixinInAppstore @"kCancelOpenWeixinInAppstore"
#define kShareByWeixin @"kShareByWeixin"

#define kCountPerSection 3

#ifndef kInAppPurchaseProductName
#define kInAppPurchaseProductName @"com.idreems.maketoast.inapp"
#endif


@interface AdsConfig : NSObject
{
    NSMutableArray *mData;
    NSInteger mCurrentIndex;
    NSMutableArray* mAdsWalls;
}
@property (nonatomic, retain) NSMutableArray* mData;
@property (nonatomic, assign) NSInteger mCurrentIndex;

+(AdsConfig*)sharedAdsConfig;
+(void)reset;
+(NSDate*)currentLocalDate;

+(BOOL) isAdsOn;
+(BOOL) isAdsOff;
+(void) setAdsOn:(BOOL)enable type:(NSString*)type;
+(BOOL)neverCloseAds;

-(NSString*)wallShowString;
-(NSString *)getAdsTestVersion:(const NSUInteger)index;
-(BOOL)wallShouldShow;
-(void)init:(NSString*)path;
-(NSArray*)getAdsWalls;

-(NSString*)getFirstAd;

-(NSString*)getLastAd;

-(NSInteger)getAdsCount;

-(NSString*)toNextAd;

-(NSString*)getCurrentAd;

-(BOOL)isCurrentAdsValid;
-(NSInteger)getCurrentIndex;

-(BOOL)isInitialized;

-(void)dealloc;

@end