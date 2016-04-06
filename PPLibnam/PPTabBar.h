//
//  PPTabBar.h
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPTabBar;
@protocol PPTabBarDeledate <UITabBarDelegate>

//- (void)tabBarDidClickPlusButton:(PPTabBar *)tabBar midButton:(UIButton *)button;
- (void)tabBarDidClickPlusButton:(UIButton *)button;

@end

@interface PPTabBar : UITabBar

@property (nonatomic,weak) id<PPTabBarDeledate>delegate;

@end
