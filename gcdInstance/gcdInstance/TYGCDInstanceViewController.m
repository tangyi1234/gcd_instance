//
//  TYGCDInstanceViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/26.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYGCDInstanceViewController.h"

@interface TYGCDInstanceViewController ()

@end

@implementation TYGCDInstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 64, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"加载" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 100, 100, 30);
    but1.backgroundColor = [UIColor redColor];
    [but1 setTitle:@"主线程执行" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    
}

- (void)selectorBut {
    //用同步函数向串行队列添加任务，不创建线程
//    dispatch_sync(dispatch_queue_create("sync_cx", NULL), ^{
//        NSLog(@"同步串行:%@",[NSThread currentThread]);
//    });
    
    //用同步函数向并发队列添加任务
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"同步并发:%@",[NSThread currentThread]);
//    });
//
    //用异步函数向串行队列添加任务，开辟新线程(只开辟一条线程)
//    dispatch_queue_t queue = dispatch_queue_create("async_cx", NULL);
//    dispatch_async(queue, ^{
//        for (int i=0; i<10000; i++) {
//            NSLog(@"异步串行队列1:%@",[NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"异步串行队列2:%@",[NSThread currentThread]);
//    });
//
    //用异步函数并发添加任务，开辟多条线程(这里是开启多少条是受限制的)
    dispatch_queue_t queues = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queues, ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"异步并行队列1:%@",[NSThread currentThread]);
        }
    });

//    dispatch_async(queues, ^{
//        NSLog(@"异步并行队列2:%@",[NSThread currentThread]);
//    });
}

- (void)selectorBut1 {
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
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
