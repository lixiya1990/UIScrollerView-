//
//  FourViewController.m
//  UIScrollerView研究
//
//  Created by lixiya on 16/3/21.
//  Copyright © 2016年 lixiya. All rights reserved.
//
#define KPageWidth    250
#define KPageMargin   20
#define KPageNumber   20

#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width

#import "FourViewController.h"
#import "BottomTouchDelegateView.h"

@interface FourViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;
@property(nonatomic ,strong) UIView * contentView;

@end

@implementation FourViewController

/**
 *  1.pagingEnabled 系统提供的分页方式
 */


/**
 *  clipsToBounds
 *  子viewframe超出父view时可以正常显示(设置NO)
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
        _myScrollView.pagingEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.clipsToBounds = NO;
        _myScrollView.contentSize = CGSizeMake(W*KPageNumber, 0);
        
        // 添加图片
        CGFloat viewX = KPageMargin/2;
        for (NSInteger i = 0; i<KPageNumber; i++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(viewX, (H-KPageWidth)/2, KPageWidth, KPageWidth)];
            view.layer.cornerRadius = KPageWidth/2;
            view.layer.masksToBounds = YES;
            view.backgroundColor = [UIColor blueColor];
            [self.contentView addSubview:view];
            
            viewX += KPageWidth+KPageMargin;
        }
        
    }
    return _myScrollView;
}

-(UIView *)contentView{

    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myScrollView.contentSize.width, self.myScrollView.frame.size.height)];
        _contentView.backgroundColor = [UIColor yellowColor];
        [self.myScrollView addSubview:_contentView];
    }
    return _contentView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
