//
//  TwoViewController.m
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//
#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width


#import "TwoViewController.h"
#import "BottomTouchDelegateView.h"
#import "SMPageControl.h"
@interface TwoViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;
@property(nonatomic ,strong) UIImageView * bottomImgView;
@property(nonatomic ,strong) UILabel * titleLab;
@property(nonatomic ,strong) SMPageControl * pageControl;

@property(nonatomic ,strong) UIButton * goButton;
@property(nonatomic ,strong) NSMutableArray * titleArry;
@end

@implementation TwoViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.alpha = 1;
    
    // 开启侧滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 侧滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.goButton];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.titleLab];
    
    [self.bottomView addSubview:self.bottomImgView];
    [self.bottomView addSubview:self.myScrollView];
    
    // 关联
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

-(UIImageView *)bottomImgView{
    
    if (!_bottomImgView) {
        _bottomImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomImgV"]];
        _bottomImgView.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        
    }
    return _bottomImgView;
}

-(UIScrollView *)myScrollView{
    
    // 背景图片宽高：375/667  手机框宽高：165/293
    if (!_myScrollView) {
        CGFloat scrollW = 165*IphoneWidth/375;
        CGFloat scrollH = 293*IphoneHeight/667;
        CGFloat mx = (IphoneWidth-scrollW)/2;
        CGFloat my = 190*IphoneHeight/667;
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(mx, my,scrollW , scrollH)];
        _myScrollView.backgroundColor = [UIColor whiteColor];
        _myScrollView.delegate = self;
        _myScrollView.pagingEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.contentSize = CGSizeMake(scrollW*4, 0);
        
        // 添加图片
        for (NSInteger i = 0; i<4; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%ld",i+1]];
            UIImageView * imageV = [[UIImageView alloc] initWithImage:image];
            imageV.frame = CGRectMake(scrollW*i, 0, scrollW, scrollH);
            [_myScrollView addSubview:imageV];
        }
        
    }
    return _myScrollView;
}


-(UIButton *)goButton{
    
    if (!_goButton) {
        _goButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _goButton.frame = CGRectMake(IphoneWidth, IphoneHeight/2-15, 100, 30); // 开始默认隐藏
        [_goButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [_goButton addTarget:self action:@selector(goButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_goButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_goButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        
    }
    return _goButton;
    
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, IphoneWidth, 40)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"每周精彩演出推荐";
        _titleLab.font = [UIFont systemFontOfSize:20];
    }
    return _titleLab;
    
}

-(SMPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[SMPageControl alloc] init];
        _pageControl.frame = CGRectMake((IphoneWidth-200)/2, IphoneHeight-100, 200, 30);
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = 4;
        _pageControl.indicatorMargin = 20; // 间距
        _pageControl.indicatorDiameter = 10; // 圆点大小
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        //[_pageControl addTarget:self action:@selector(spacePageControl:) forControlEvents:UIControlEventValueChanged];
        for (NSInteger i = 0; i<4; i++) {
            [_pageControl setCurrentImage:[UIImage imageNamed:[NSString stringWithFormat:@"page_icon_%ld",i+1]] forPage:i];
        }
        
        // 默认第一个
        _pageControl.currentPage = 0;
        
        
    }
    return _pageControl;
}

-(NSMutableArray *)titleArry{
    
    if (!_titleArry) {
        _titleArry = [NSMutableArray arrayWithObjects:@"每周精彩演出推荐",@"更好的购购票选座体验",@"最独家的头条报道",@"互动送票活动", nil];
    }
    return _titleArry;
}

#pragma mark - methods
-(void)goButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollerView协议方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
     CGPoint point = scrollView.contentOffset;
     CGFloat x = point.x;
     CGFloat scrollW = scrollView.frame.size.width;
     NSLog(@"_____%f",x);
     _pageControl.currentPage = x/scrollW;
     
     NSInteger index = x/scrollW;
     _titleLab.text = self.titleArry[index];
     
     if (x == scrollW*3) {
     [UIView animateWithDuration:0.2 animations:^{
     CGRect frame = self.goButton.frame;
     frame.origin.x = IphoneWidth-100;
     self.goButton.frame = frame;
     } completion:^(BOOL finished) {
     
     }];
     }else if(x>scrollW*3+500){
     
     [self.navigationController popViewControllerAnimated:YES];
     }
     
     
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
