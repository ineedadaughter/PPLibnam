//
//  HomeCoverView.h
//  PPLibnam
//
//  Created by donfer on 16/3/25.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCoverView : UIView
@property (nonatomic, copy) void (^MainViewControllerBlock)(int tag);
- (void)transform;

@end
