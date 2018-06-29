//
//  TYThreadViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/28.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYThreadViewController.h"
#import "TYNSThreadViewController.h"
#import "TYOperationViewController.h"

#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height
@interface TYThreadViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation TYThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _array = [NSArray arrayWithObjects:@"NSThread",@"NSOperation", nil];
    [self initTableView];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, w, h) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TYNSThreadViewController *vc = [[TYNSThreadViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        TYOperationViewController *vc = [[TYOperationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
