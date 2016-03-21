//
//  FiveViewController.m
//  UIScrollerView研究
//
//  Created by lixiya on 16/3/21.
//  Copyright © 2016年 lixiya. All rights reserved.
//


#define KPageWidth    80
#define KPageMargin   20
#define KPageNumber   20

#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width

#import "FiveViewController.h"
#import "BottomTouchDelegateView.h"

@interface FiveViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;

@end

@implementation FiveViewController


/**
 *
 *  2.在 didEndDragging 且无减速动画，或在减速动画完成时，snap 到一个整数页。核心算法是通过当前 contentOffset 计算最近的整数页及其对应的 contentOffset，通过动画 snap 到该页。这个方法实现的效果都有个通病，就是最后的 snap 会在 decelerate 结束以后才发生，总感觉很突兀
 *
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    
    //.
    self.bottomView.myScrollView = self.myScrollView;
}

#pragma mark - getter
-(UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[BottomTouchDelegateView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.myScrollView];
        
    }
    return _bottomView;
}

-(UIScrollView *)myScrollView{
    
    if (!_myScrollView) {
        CGFloat W = KPageWidth+KPageMargin;
        CGFloat H = IphoneHeight;
        CGFloat X = (IphoneWidth-W)/2;
        CGFloat Y = 0;
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(X, Y,W , H)];
        _myScrollView.backgroundColor = [UIColor redColor];
        _myScrollView.delegate = self;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.clipsToBounds = NO;
        _myScrollView.delegate = self;
        _myScrollView.contentSize = CGSizeMake(W*KPageNumber, 0);
        
        // 添加图片
        CGFloat viewX = KPageMargin/2;
        for (NSInteger i = 0; i<KPageNumber; i++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(viewX, (H-KPageWidth)/2, KPageWidth, KPageWidth)];
            view.layer.cornerRadius = KPageWidth/2;
            view.layer.masksToBounds = YES;
            view.backgroundColor = [UIColor blueColor];
            [self.myScrollView addSubview:view];
            
            viewX += KPageWidth+KPageMargin;
        }
        
    }
    return _myScrollView;
}


-(void)snapToNearestItem:(CGPoint)point{
    NSInteger index = roundf(point.x/self.myScrollView.frame.size.width);
    [self.myScrollView setContentOffset:CGPointMake(index*self.myScrollView.frame.size.width, point.y) animated:YES];
}

#pragma mark - UIScrllerView协议方法

// 停止拖动时立即执行
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        [self snapToNearestItem:scrollView.contentOffset];
    }
    
}

// 停止拖动后如果有减速行为，减速结束时执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self snapToNearestItem:scrollView.contentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
