//
//  Common.h
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef Common_h
#define Common_h

#pragma mark - 颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kCommonGrayTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]
#define kCommonRedColor [UIColor colorWithRed:0.91f green:0.33f blue:0.33f alpha:1.00f]
#define kBgColor kRGBColor(243,245,247)
#define kLineBgColor [UIColor colorWithRed:0.86f green:0.88f blue:0.89f alpha:1.00f]
#define kTextColor [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]
#define kSeperatorColor kRGBColor(234,237,240)
#define kDetailTextColor [UIColor colorWithRed:0.56f green:0.60f blue:0.62f alpha:1.00f]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]
#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]

/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  像素*/
#define KPixel (kScreenWidth/640)
/** 默认图片*/
#define kDefaultImage [UIImage imageNamed:@"Image_online"]

#define kStatusBarH 20
#define kNavigationBarH 44
#define kTabbarH 44

//调试模式下输入DLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog_Cus(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog_Cus(...)
#endif

#endif /* Common_h */
