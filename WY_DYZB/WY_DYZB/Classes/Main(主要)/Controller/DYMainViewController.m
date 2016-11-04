//
//  DYMainViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DYMainViewController.h"
#import "DYHomeViewController.h"
#import "DYLiveViewController.h"
#import "DYFollowViewController.h"
#import "DYMineViewController.h"

@interface DYMainViewController ()

@end

@implementation DYMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addChildViewControllerWithClassName:[DYHomeViewController description] title:@"首页" normalImgName:@"btn_home_normal" selectedImgName:@"btn_home_selected"];
    [self addChildViewControllerWithClassName:[DYLiveViewController description] title:@"直播" normalImgName:@"btn_column_normal" selectedImgName:@"btn_column_selected"];
    [self addChildViewControllerWithClassName:[DYFollowViewController description] title:@"关注" normalImgName:@"btn_live_normal" selectedImgName:@"btn_live_selected"];
    [self addChildViewControllerWithClassName:[DYMineViewController description] title:@"我的" normalImgName:@"btn_user_normal" selectedImgName:@"btn_user_selected"];
    
    /**
     *iOS7之后UITextAttributeTextColor的替代方法
     *  UITextAttributeTextColor ------> NSForegroundColorAttributeName
     *
     *[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
     *即上面的代码改为
     *[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
     */
    
    // 默认状态下的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    // 选中状态下的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kRGBColor(255, 119, 0),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    // Do any additional setup after loading the view.
}


#pragma mark - 添加自控制器
- (void)addChildViewControllerWithClassName:(NSString *)className title:(NSString *)title normalImgName:(NSString *)normalImgName selectedImgName:(NSString *)selectedImgName
{
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:normalImgName];
    
    /**
     * UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     * UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
     * UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
     */
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
