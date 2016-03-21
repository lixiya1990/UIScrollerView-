//
//  BottomTouchDelegateView.h
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomTouchDelegateView : UIView

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) UIButton * testButton; // 用来测试hitTest方法

@end
