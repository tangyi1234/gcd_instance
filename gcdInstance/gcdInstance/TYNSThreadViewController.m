//
//  TYNSThreadViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/28.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYNSThreadViewController.h"

@interface TYNSThreadViewController ()

@end

@implementation TYNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 64, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"动态创建" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 100, 100, 30);
    but1.backgroundColor = [UIColor yellowColor];
    [but1 setTitle:@"静态创建" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 140, 100, 30);
    but2.backgroundColor = [UIColor greenColor];
    [but2 setTitle:@"保持当前线程" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 200, 100, 300);
    but3.backgroundColor = [UIColor orangeColor];
    [but3 setTitle:@"永久保持当前线程" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
}
//动态创建线程
- (void)selectorBut {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadSelector) object:nil];
    thread.threadPriority = 1;// 设置线程的优先级(0.0 - 1.0，1.0最高级)
    [thread start];
}

//静态创建
- (void)selectorBut1 {
    [NSThread detachNewThreadSelector:@selector(loadSelector) toTarget:self withObject:nil];
}

- (void)loadSelector {
    for (int i = 0; i < 10; i++) {
        NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
    }
}

//保持当前线程
- (void)selectorBut2 {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(selectorKeep) object:nil];
    thread.threadPriority = 1;
    [thread start];
    //先监听线程退出的通知，以便知道线程什么时候退出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
}

//
- (void)selectorBut3 {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(selectorKeeps) object:nil];
    thread.threadPriority = 1;
    [thread start];
    //先监听线程退出的通知，以便知道线程什么时候退出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
}

- (void)selectorKeep {
    NSLog(@"还会执行当前线程是什么:%@",[NSThread currentThread]);
    [[NSThread currentThread] setName:@"myThread"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//    while (![[NSThread currentThread] isCancelled]) {//这里的作用是持续的添加，持续运行
        //[NSDate dateWithTimeIntervalSinceNow:10]这个方法的意思就是10个单位后将线程取消调。
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
//    }
}

- (void)selectorKeeps {
    [[NSThread currentThread] setName:@"myThread1"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //    while (![[NSThread currentThread] isCancelled]) {//这里的作用是持续的添加，持续运行
    //[NSDate dateWithTimeIntervalSinceNow:10]这个方法的意思就是10个单位后将线程取消调。
    [runLoop runUntilDate:[NSDate date]];
}

//监控线程
- (void)threadExitNotice {
    NSLog(@"这是那个线程提出了:%@",[NSThread currentThread].name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 NSThread趋向与底层一点，使用起来还算方便。他只有两两种模式，一个主线程和异步，直白点就是一个是单线程一个是多线程。它没有GCD那么多。很适合做一些简单开发线程的时候，它很适合。
 在使用的时候，在执行完毕后就销毁线程。所以想让创建的线程不被销毁掉，就引入了runLoop机制来实现。
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
