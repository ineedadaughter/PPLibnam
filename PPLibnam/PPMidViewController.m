//
//  PPMidViewController.m
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "PPMidViewController.h"

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface PPMidViewController ()

@end

@implementation PPMidViewController
{
    UIButton * _backBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self setBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackButton:(NSString *)title {
    // 返回按钮
    [self setBackButton:title withFrame:CGRectMake(0, 0, 55.0, 60.0)];
}

-(void)setBackButton:(NSString *)title withFrame:(CGRect) backFrame {
    
    // 返回按钮
    self.navigationItem.hidesBackButton=NO;
    _backBtn = [[UIButton alloc] initWithFrame:backFrame];
    _backBtn.tag=111;
    [_backBtn setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    [_backBtn setTitle:title forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _backBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    if (IOS_VERSION>=7.0) {
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -15, 15, 15)];
        if (title) {
            [_backBtn setTitleEdgeInsets:UIEdgeInsetsMake(15, -15, 15, 15)];
        }
    }else{
        
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 5, 15, 20)];
    }
    UIBarButtonItem * item=[[UIBarButtonItem alloc]initWithCustomView:_backBtn];
    [self.navigationItem setLeftBarButtonItem:item];
}

-(void)setBackButton
{
    [self setBackButton:@"返回"];
}

- (void)backAction
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
