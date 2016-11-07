//
//  NetworkSingleton.m
//  WY_DYZB
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NetworkSingleton.h"

@implementation NetworkSingleton

+ (NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    /**
     *函数void dispatch_once( dispatch_once_t *predicate, dispatch_block_t block);其中第一个参数predicate，该参数是检查后面第二个参数所代表的代码块是否被调用的谓词，第二个参数则是在整个应用程序中只会被调用一次的代码块.dispach_once函数中的代码块只会被执行一次，而且还是线程安全的
     */
    dispatch_once(&predicate, ^{
        sharedNetworkSingleton = [[NetworkSingleton alloc] init];
    });
    
    return sharedNetworkSingleton;
}

- (AFHTTPRequestOperationManager *)baseHttpRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];         // 设置请求超时时间
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", nil];
    
    return manager;
}

#pragma mark - 获取首页的推荐、颜值、其他的数据
- (void)getRecommendDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    // 推荐数据
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    __block NSArray *tuijianArray = [[NSArray alloc] init];
    __block NSArray *yanzhiArray = [[NSArray alloc] init];
    __block NSArray *otherArray = [[NSArray alloc] init];

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_SERIAL);
    
    // 请求第一部分最热数据
    dispatch_group_enter(group);
    
    dispatch_group_async(group, queue, ^{
        NSString *url = @"http://capi.douyucdn.cn/api/v1/getbigDataRoom";
        NSDictionary *userInfo = @{@"time":[self GetNowTimes]};
        
        // unsupported URL:请求的串中包含有中文字符则会报错，返回unsupported URL，所以要加下面这句代码
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      // IOS9之前会警告

        [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
//            successBlock(responseObject);
            
            tuijianArray = [responseObject objectForKey:@"data"];
            
            dispatch_group_leave(group);

            NSLog_Cus(@"推荐数据tuijianArray.count=======%ld",tuijianArray.count);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            NSLog_Cus(@"errorStr=====%@",errorStr);
            
            dispatch_group_leave(group);

//            failureBlock(errorStr);
        }];
    });
    
    
    dispatch_group_enter(group);

    // 请求第二部分颜值数据
    dispatch_group_async(group, queue, ^{
        NSString *url = @"http://capi.douyucdn.cn/api/v1/getVerticalRoom";
        NSDictionary *userInfo = @{@"limit":@"4",@"offset":@"0",@"time":[self GetNowTimes]};
        
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      // IOS9之前会警告
        
        [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
            //            successBlock(responseObject);
            
            yanzhiArray = [responseObject objectForKey:@"data"];
            
            dispatch_group_leave(group);

            NSLog_Cus(@"颜值数据yanzhiArray.count=======%ld",yanzhiArray.count);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            NSLog_Cus(@"errorStr=====%@",errorStr);
            dispatch_group_leave(group);

            //            failureBlock(errorStr);
        }];
    });

    dispatch_group_enter(group);

    // 请求2-12部分游戏数据
    dispatch_group_async(group, queue, ^{
        NSString *url = @"http://capi.douyucdn.cn/api/v1/getHotCate";
        NSDictionary *userInfo = @{@"limit":@"4",@"offset":@"0",@"time":[self GetNowTimes]};
        
        // unsupported URL:请求的串中包含有中文字符则会报错，返回unsupported URL，所以要加下面这句代码
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      // IOS9之前会警告
        
        [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
            //            successBlock(responseObject);
            
            otherArray = [responseObject objectForKey:@"data"];
            
            dispatch_group_leave(group);

            NSLog_Cus(@"其他数据otherArray.count=======%ld",otherArray.count);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            NSLog_Cus(@"errorStr=====%@",errorStr);
            dispatch_group_leave(group);

            //            failureBlock(errorStr);
        }];
    });
    
    
    dispatch_group_notify(group, queue, ^{
        NSLog_Cus(@"请求全部完成");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [dataArray addObject:tuijianArray];
            [dataArray addObject:yanzhiArray];
            [dataArray addObject:otherArray];

            successBlock(dataArray);
            NSLog_Cus(@"NetworkSingleton == dataArray.count=====%ld",dataArray.count);
        });
    });
}

#pragma mark - 获取首页-推荐-无限轮播的数据
- (void)getRecommendCycleDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    NSString *url = @"http://www.douyutv.com/api/v1/slide/6";
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      // IOS9之前会警告

    NSDictionary *userInfo = @{@"version":@"2.300"};

    [manager GET:url parameters:userInfo success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSLog_Cus(@"errorStr=====%@",errorStr);
        failureBlock(errorStr);
    }];
    
}
#pragma mark - 获取当前时间戳
- (NSString *)GetNowTimes
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", timeInterval];
    
    return timeString;
}



@end
