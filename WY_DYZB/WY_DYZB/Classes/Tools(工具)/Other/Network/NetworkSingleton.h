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

#pragma mark - 获取首页的推荐、颜值、其他的数据
- (void)getRecommendDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
