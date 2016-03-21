//
//  ThreeViewController.m
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//

#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width


#import "ThreeViewController.h"
#import "SMPageControl.h"
#import <POP/POP.h>

@interface ThreeViewController ()<UIScrollViewDelegate>

@property(nonatomic ,strong) UIScrollView * myScrollView;
@property(nonatomic ,strong) UIScrollView * aboveScrollView;
@property(nonatomic ,strong) UIImageView * bottomImgView;
@property(nonatomic ,strong) UILabel * titleLab;
@property(nonatomic ,strong) SMPageControl * pageControl;
@property(nonatomic ,strong) UIImageView * showImgV;

@property(nonatomic ,strong) UIButton * goButton;
@property(nonatomic ,strong) NSMutableArray * titleArry;
@end

@implementation ThreeViewController

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
    
    
    [self.view addSubview:self.bottomImgView];
    [self.view addSubview:self.myScrollView];
    [self.view addSubview:self.aboveScrollView];
    [self.view addSubview:self.goButton];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.showImgV];


}

#pragma mark - getter

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

-(UIScrollView *)aboveScrollView{
    if (!_aboveScrollView) {

        _aboveScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,IphoneWidth , IphoneHeight)];
        _aboveScrollView.backgroundColor = [UIColor clearColor];
        _aboveScrollView.delegate = self;
        _aboveScrollView.pagingEnabled = YES;
        _aboveScrollView.showsHorizontalScrollIndicator = NO;
        _aboveScrollView.showsVerticalScrollIndicator = NO;
        _aboveScrollView.contentSize = CGSizeMake(IphoneWidth*4, 0);
        
    }
    return _aboveScrollView;
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
        _pageControl.frame = CGRectMake((IphoneWidth-200)/2, IphoneHeight-80, 200, 30);
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

-(UIImageView *)showImgV{

    if (!_showImgV) {
        _showImgV = [[UIImageView alloc] init];
        _showImgV.backgroundColor = [UIColor blueColor];
        
        
    }
    return _showImgV;
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

    if (scrollView == self.aboveScrollView) {
        CGPoint point = scrollView.contentOffset;
        CGFloat x = point.x;
        // 根据最上层scrollerView的偏移量来计算底部scrollerView的偏移量
        CGFloat mx = (self.myScrollView.frame.size.width*x)/IphoneWidth;
        self.myScrollView.contentOffset = CGPointMake(mx, 0);
        
        //  大于IphoneWidth/2 改变文字和_pageControl
        NSInteger pointIndex = x/IphoneWidth;
        NSLog(@"_____%ld___%f",pointIndex,x);
        if (x>IphoneWidth/2+IphoneWidth*pointIndex) {
            if (pointIndex<3) {
                pointIndex+=1;
            }
        }else if(x<IphoneWidth*pointIndex-IphoneWidth/2){
            if (pointIndex>0) {
                pointIndex-=1;
            }
        }
        _pageControl.currentPage = pointIndex;
        _titleLab.text = self.titleArry[pointIndex];

        // 立即体验按钮显示
        if (x == IphoneWidth*3) {
            [UIView animateWithDuration:0.2 animations:^{
                CGRect frame = self.goButton.frame;
                frame.origin.x = IphoneWidth-100;
                self.goButton.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        }else if(x>IphoneWidth*3+100){
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        // 动画显示showImgV
        CGFloat myScroW = self.myScrollView.frame.size.width;
        CGFloat myScroH = self.myScrollView.frame.size.height;
        CGFloat myScroX = self.myScrollView.frame.origin.x;
        CGFloat myScroY = self.myScrollView.frame.origin.y;

        // 这里只能暂时通过self.pageControl.currentPage来判断  刚开始通过x = IphoneWidth*1.5来判断 但是打印输出 x的值不是逐个递增或者递减的 滚动的时候x不一定 = IphoneWidth*1.5
        if (self.pageControl.currentPage == 1) {
            if (self.showImgV.frame.size.width>0) {
                return;
            }
            //..缩放动画
            POPSpringAnimation * scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            scaleAnimation.springBounciness = 10;
            scaleAnimation.springSpeed = 5;
            scaleAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(myScroX+myScroW/2, myScroY+myScroH/2, 0, 0)];
            scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(myScroX+myScroW*0.9, myScroY+myScroH*0.2, 50, 50)];
            [self.showImgV pop_addAnimation:scaleAnimation forKey:@"scaleAnimation_MenuButtonView"];
        }else{
            if (self.showImgV.frame.size.width<50) {
                return;
            }
            //..缩放动画
            POPSpringAnimation * scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            scaleAnimation.springBounciness = 10;
            scaleAnimation.springSpeed = 5;
            scaleAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(myScroX+myScroW*0.9, myScroY+myScroH*0.2, 50, 50)];
            scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(myScroX+myScroW/2, myScroY+myScroH/2, 0, 0)];
            [self.showImgV pop_addAnimation:scaleAnimation forKey:@"scaleAnimation_MenuButtonView"];
         
         }
        
    }

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
