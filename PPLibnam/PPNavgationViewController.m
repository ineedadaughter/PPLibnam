//
//  PPNavgationViewController.m
//  PPLibnam
//
//  Created by donfer on 16/3/25.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "PPNavgationViewController.h"



@interface PPNavgationViewController ()

@end

@implementation PPNavgationViewController

//初始化只一次

+(void)initialize
{
    
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    NSMutableDictionary *disTextAttrs = [NSMutableDictionary dictionary];
//    disTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    disTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:disTextAttrs forState:UIControlStateDisabled];
}

//重写pushViewController，滑动时hidesBottomBarWhenPushed；
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
//        重写返回按钮
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"fanhui" style:UIBarButtonItemStylePlain target:self action:@selector(left)];
//        viewController.navigationItem.leftBarButtonItem = item;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)left
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.tintColor = [UIColor blackColor];
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
