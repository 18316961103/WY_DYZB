//
//  YanZhiModel.h
//  WY_DYZB
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YanZhiModel : NSObject

@property (strong, nonatomic) NSString *vertical_src;   // 图片url
@property (strong, nonatomic) NSString *nickname;       // 主播名字
@property (strong, nonatomic) NSString *anchor_city;    // 所在城市
@property (strong, nonatomic) NSString *online;         // 在线人数
@property (strong, nonatomic) NSString *room_name;      // 直播标题

@end
