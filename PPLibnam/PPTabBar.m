//
//  PPTabBar.m
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "PPTabBar.h"
@interface PPTabBar()

@property (nonatomic,weak) UIButton *plusButton;

@end
@implementation PPTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"icon-plus-highlighted"] forState:UIControlStateNormal];
//        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"icon-plus"] forState:UIControlStateSelected];
        self.plusButton.selected = NO;
        self.plusButton.frame = CGRectMake(0, -100, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height);
        [self.plusButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void)btnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self.plusButton];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    CGFloat tabBarButtonW = self.frame.size.width/5;
    CGFloat tabBarButtonIndex = 0;
    
//    遍历找到UITabBarButton的按钮
    for (UIView *chidView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([chidView isKindOfClass:class]) {
            CGRect frame = chidView.frame;
            frame.origin.x = tabBarButtonIndex*tabBarButtonW;
            frame.size.width = tabBarButtonW;
            chidView.frame = frame;
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
