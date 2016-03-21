//
//  OneViewController.m
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//
#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width


#import "OneViewController.h"
#import "BottomTouchDelegateView.h"

@interface OneViewController ()

@property(nonatomic ,strong) BottomTouchDelegateView * bottomView;

@property(nonatomic ,strong) UIButton * testButton;
@property(nonatomic ,strong) UIView * clearView;


@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.testButton];
    [self.bottomView addSubview:self.clearView];
    
    // 关联
    self.bottomView.testButton = self.testButton;
    
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[BottomTouchDelegateView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIView *)clearView{
    if (!_clearView) {
        _clearView = [[BottomTouchDelegateView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        _clearView.backgroundColor = [UIColor redColor];
        _clearView.backgroundColor = [UIColor clearColor];
    }
    return _clearView;

}

-(UIButton *)testButton{
    
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _testButton.frame = CGRectMake((IphoneWidth-100)/2, 200, 100, 30); // 开始默认隐藏
        [_testButton setTitle:@"hitTest测试" forState:UIControlStateNormal];
        [_testButton addTarget:self action:@selector(testButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_testButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_testButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
    return _testButton;
    
}

-(void)testButtonClick{

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"点击了button" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
