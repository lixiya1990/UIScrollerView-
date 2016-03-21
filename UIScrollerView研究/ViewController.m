//
//  ViewController.m
//  UIScrollerView探究
//
//  Created by lixiya on 16/3/17.
//  Copyright © 2016年 lixiya. All rights reserved.
//

#define IphoneHeight  [[UIScreen mainScreen] bounds].size.height
#define IphoneWidth  [[UIScreen mainScreen] bounds].size.width

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView * tv;
@property(nonatomic ,strong) NSMutableArray * dataList;

@end

@implementation ViewController

#pragma mark - vc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UIScrollerView探究";
    
    [self.view addSubview:self.tv];
    
}

#pragma mark - getter
-(UITableView *)tv{
    
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight) style:UITableViewStylePlain];
        _tv.delegate = self;
        _tv.dataSource = self;
    }
    return _tv;
}

-(NSMutableArray *)dataList{
    
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataList" ofType:@"plist"]];
    }
    return _dataList;
}

#pragma mark - 表的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [self.dataList[indexPath.row] objectForKey:@"title"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController * vc = [NSClassFromString([self.dataList[indexPath.row] objectForKey:@"classString"]) new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
