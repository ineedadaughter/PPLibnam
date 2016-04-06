//
//  MainViewController.m
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "MainViewController.h"
#import "PPFirstViewController.h"
#import "PPSecondViewController.h"
#import "PPThirdViewController.h"
#import "PPFourViewController.h"
#import "PPMidViewController.h"
#import "PPTabBar.h"
#import "HomeCoverView.h"
#import "PPNavgationViewController.h"

@interface MainViewController ()<PPTabBarDeledate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[PPFirstViewController alloc] init] title:@"first" image:@"VIP_黑" selectedImage:@"VIP_on"];
    [self addChildViewController:[[PPSecondViewController alloc] init] title:@"second" image:@"发现_黑" selectedImage:@"发现_on"];
    [self addChildViewController:[[PPThirdViewController alloc] init] title:@"third" image:@"首页_黑" selectedImage:@"首页_on"];
    [self addChildViewController:[[PPFourViewController alloc] init] title:@"four" image:@"我的_黑" selectedImage:@"我的_on"];
    
    PPTabBar *ppTabBar= [[PPTabBar alloc] init];
    ppTabBar.delegate = self;
//    tabbar是readonly的属性，所以当前方法无法赋值成功
//    self.tabBar = ppTabBar;
    [self setValue:ppTabBar forKey:@"tabBar"];
    
    
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage
{
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    PPNavgationViewController *nav = [[PPNavgationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tabBarDelegate
- (void)tabBarDidClickPlusButton:(UIButton *)button
{
    button.selected = !button.selected;
    
    HomeCoverView *view = [[HomeCoverView alloc] initWithFrame:self.view.bounds];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.95;
        [view transform];
    }];
    
    PPNavgationViewController *nav = [[PPNavgationViewController alloc] initWithRootViewController:[[PPMidViewController alloc] init]];
    
    __weak HomeCoverView *weakView = view;
    
    view.MainViewControllerBlock = ^(int tag){
        [self presentViewController:nav animated:YES completion:^{
            [weakView removeFromSuperview];
        }];
    };
    
    [self.view addSubview:view];
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
