//
//  NetworkSingleton.h
//  WY_DYZB
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIMEOUT 30

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSString *error);

@interface NetworkSingleton : NSObject

+ (NetworkSingleton *)sharedManager;
- (AFHTTPRequestOperationManager *)baseHttpRequest;

/** 获取首页的推荐、颜值、其他的数据*/
- (void)getRecommendDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/** 获取首页-推荐-无限轮播的数据*/
- (void)getRecommendCycleDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/** 获取首页-游戏的数据*/
- (void)getHomeGameDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/** 获取首页-娱乐的数据*/
- (void)getHomeEntertainmentDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/** 获取首页-趣玩的数据*/ 
- (void)getHomeFunDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/** 获取首页-手游的数据*/
- (void)getHomeMobileGameDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
