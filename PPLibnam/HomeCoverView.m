//
//  HomeCoverView.m
//  PPLibnam
//
//  Created by donfer on 16/3/25.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "HomeCoverView.h"
#import <QuartzCore/QuartzCore.h>

#define ButtonW 60.f
@interface HomeCoverView()

@property(nonatomic,strong) NSMutableArray *buttonArray;

@end
@implementation HomeCoverView{
    UIButton *addBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"icon-plus-highlighted"] forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(0, 0, addBtn.currentBackgroundImage.size.width, addBtn.currentBackgroundImage.size.height);
        addBtn.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height-24.5);
        [addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        [self createButtonArray];
    }
    return self;
}

- (void )createButtonArray {
    self.buttonArray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 'A'; i < 'G'; i++) {
        [array addObject:[NSString stringWithFormat:@"%c",i]];
    }
    int m = 0;
    for (NSString *title in array) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        NSInteger i = m/3;
        NSInteger j = m%3;
        CGFloat space = (self.frame.size.width-ButtonW*3)/4.0;
        
        CGFloat x = space*(j+1)+ButtonW*j;
        CGFloat y = self.frame.size.height*0.4+(ButtonW+20)*i;
        button.frame = CGRectMake(x, self.frame.size.height+ButtonW, ButtonW, ButtonW);
        [UIView animateWithDuration:0.3+0.1*j animations:^{
            button.frame = CGRectMake(x, y-ButtonW*0.4, ButtonW, ButtonW);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                button.frame = CGRectMake(x, y, ButtonW, ButtonW);
            }];
        }];
        
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        int colorBlu = arc4random()%255;
        int colorRed = arc4random()%255;
        int colorGre = arc4random()%255;
        
        button.backgroundColor = [UIColor colorWithRed:colorRed/255.0 green:colorGre/255.0 blue:colorBlu/255.0 alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = m++;
        [button addTarget:self action:@selector(bigAnimaTion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
    }
    
}

- (void)btnClick
{
    [self beginAnimationWithType:0];
}

- (void)transform
{
    [self beginAnimationWithType:1];
}

- (void)slowDown
{


}

- (void)bigAnimaTion:(UIButton *)button
{
    CAAnimationGroup *blowup = [self _blowupAnimationAtPoint:button.center];
    [button.layer addAnimation:blowup forKey:@"blowup"];
//    button.center = button.startPoint;
    
    [self performSelector:@selector(sleep:) withObject:nil afterDelay:0.2];
}

- (void)sleep:(UIButton *)button
{
    self.MainViewControllerBlock((int)button.tag);
}

- (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p
{
    //位置动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.5], nil];
    
    //尺寸动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
    
    //透明动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.3f;
    animationgroup.fillMode = kCAFillModeForwards;
    
    return animationgroup;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self beginAnimationWithType:0];
}

- (void)beginAnimationWithType:(int)type
{
    if (type == 0) {
        for (int i = self.buttonArray.count; i>0; i--) {
            UIButton *button = self.buttonArray[i-1];
            [UIView animateWithDuration:0.8-(i-1)*0.1 animations:^{
                CGRect frame = button.frame;
                frame.origin.y = self.frame.size.height+ButtonW;
                button.frame = frame;
                
            }completion:^(BOOL finished) {
                
            }];
        }
    }

    [UIView animateWithDuration:0.3 animations:^{
        switch (type) {
            case 0:
                self.alpha = 0;
                addBtn.transform = CGAffineTransformMakeRotation(0);

                break;
            case 1:
                addBtn.transform = CGAffineTransformMakeRotation(M_PI/360.f*-90);
                break;
                
            default:
                break;
        }
    }completion:^(BOOL finished) {
        switch (type) {
            case 0:
                [self removeFromSuperview];
                break;
                
            default:
                break;
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
