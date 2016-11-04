//
//  NSDictionary+Unicode.m
//  WY_DYZB
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDictionary+Unicode.h"

@implementation NSDictionary (Unicode)

- (NSString *)my_description {
    NSString *desc = [self my_description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end
