//
//  BottomTouchDelegateView.m
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//


/**
 
 // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
 - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
 // 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
 - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;

 */

#import "BottomTouchDelegateView.h"

@implementation BottomTouchDelegateView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    // self.testButton点击事件处理
    // 1.将当前点击位置坐标转换到self.testButton中对应的最标点
    CGPoint hitPoint = [self convertPoint:point toView:self.testButton];
    // 2.判断转换后的坐标点是否在self.testButton中
    if ([self.testButton pointInside:hitPoint withEvent:event]) {
        NSLog(@"找到按钮的点击事件");
        // 3.返回响应事件View
        return self.testButton;
    }else{
    
        return self.myScrollView;
    }
    
    return [self hitTest:point withEvent:event];
    
  /*
   // 无论触摸哪里都返回self.myScrollView的滚动事件
    return self.myScrollView;
  */
}



@end
