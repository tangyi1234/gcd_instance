//
//  ViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/26.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "ViewController.h"
#import "TYGCDInstanceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initPushBut];
}

- (void)initPushBut {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 64, 100, 300);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"跳转" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
}

- (void)selectorBut {
    TYGCDInstanceViewController *vc = [[TYGCDInstanceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
