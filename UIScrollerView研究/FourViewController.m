//
//  FourViewController.m
//  UIScrollerView研究
//
//  Created by lixiya on 16/3/21.
//  Copyright © 2016年 lixiya. All rights reserved.
//
#define KPageWidth    200
#define KPageMargin   20
#define KPageNumber   20

#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width

#import "FourViewController.h"
#import "BottomTouchDelegateView.h"

@interface FourViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.myScrollView];
    
    //.
    self.bottomView.myScrollView = self.myScrollView;
}

#pragma mark - getter
-(UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[BottomTouchDelegateView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIScrollView *)myScrollView{
    
    if (!_myScrollView) {
        CGFloat W = KPageWidth;
        CGFloat H = IphoneHeight;
        CGFloat X = (IphoneWidth-W)/2;
        CGFloat Y = 0;
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(X, Y,W , H)];
        _myScrollView.backgroundColor = [UIColor redColor];
        _myScrollView.delegate = self;
        _myScrollView.pagingEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.clipsToBounds = NO; // 子viewframe超出父view时可以正常显示
        _myScrollView.contentSize = CGSizeMake(W*KPageNumber, 0);
        
        // 添加图片
        CGFloat viewX = KPageMargin/2;
        CGFloat viewW = KPageWidth-KPageMargin;
        for (NSInteger i = 0; i<KPageNumber; i++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(viewX, (H-W)/2, viewW, viewW)];
            view.layer.cornerRadius = viewW/2;
            view.layer.masksToBounds = YES;
            view.backgroundColor = [UIColor blueColor];
            [_myScrollView addSubview:view];
            
            viewX = viewX + viewW + viewX;
        }
        
    }
    return _myScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
