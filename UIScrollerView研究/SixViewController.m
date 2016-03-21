//
//  SixViewController.m
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

#import "SixViewController.h"
#import "BottomTouchDelegateView.h"

@interface SixViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;

@end

@implementation SixViewController


/**
 *
 *  3.通过修改 scrollViewWillEndDragging: withVelocity: targetContentOffset: 方法中的 targetContentOffset 直接修改目标 offset 为整数页位置.
 
 
 * - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
 
 * 该方法从 iOS 5 引入，在 didEndDragging 前被调用，当 willEndDragging 方法中 velocity 为 CGPointZero（结束拖动时两个方向都没有速度）时，didEndDragging 中的 decelerate 为 NO，即没有减速过程，willBeginDecelerating 和 didEndDecelerating 也就不会被调用。反之，当 velocity 不为 CGPointZero 时，scroll view 会以 velocity 为初速度，减速直到 targetContentOffset。值得注意的是，这里的 targetContentOffset 是个指针，没错，你可以改变减速运动的目的地，这在一些效果的实现时十分有用，实例章节中会具体提到它的用法，并和其他实现方式作比较。
 *
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
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


-(CGPoint)targetContentOffset:(CGPoint)point{
    NSInteger index = roundf(point.x/self.myScrollView.frame.size.width);
    return CGPointMake(index*self.myScrollView.frame.size.width, point.y);
}

#pragma mark - UIScrllerView协议方法

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    NSLog(@"velocity_____%@",NSStringFromCGPoint(velocity));
    NSLog(@"targetContentOffset_____%@",NSStringFromCGPoint(*targetContentOffset));
    
    // targetContentOffset为最终滚动结束点
    CGPoint point = [self targetContentOffset:*targetContentOffset];
    targetContentOffset->x = point.x;
    targetContentOffset->y = point.y;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
