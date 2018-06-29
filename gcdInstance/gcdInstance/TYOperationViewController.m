//
//  TYOperationViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/29.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYOperationViewController.h"
#import "TYOperation.h"
@interface TYOperationViewController ()

@end

@implementation TYOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView{
    // 在其他线程使用子类 NSInvocationOperation
//    [NSThread detachNewThreadSelector:@selector(selectorBut) toTarget:self withObject:nil];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 64, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"使用NSOperation之类操作" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 100, 100, 30);
    but1.backgroundColor = [UIColor yellowColor];
    [but1 setTitle:@"使用NSBlockOperation" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 140, 100, 30);
    but2.backgroundColor = [UIColor orangeColor];
    [but2 setTitle:@"自定义" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 180, 100, 30);
    but3.backgroundColor = [UIColor purpleColor];
    [but3 setTitle:@"使用queue" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    
    UIButton *but4 = [UIButton buttonWithType:UIButtonTypeCustom];
    but4.frame = CGRectMake(10, 220, 100, 30);
    but4.backgroundColor = [UIColor purpleColor];
    [but4 setTitle:@"queue的学习" forState:UIControlStateNormal];
    [but4 addTarget:self action:@selector(selectorBut4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but4];
    
    UIButton *but5 = [UIButton buttonWithType:UIButtonTypeCustom];
    but5.frame = CGRectMake(10, 260, 100, 30);
    but5.backgroundColor = [UIColor purpleColor];
    [but5 setTitle:@"queue的学习" forState:UIControlStateNormal];
    [but5 addTarget:self action:@selector(selectorBut5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but5];
}

- (void)selectorBut {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    [op start];
}

- (void)invocationOperation {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
    /*
     打印结果：NSInvocationOperation单独使用时，使用的是当前个线程。这里是主线程
     2018-06-29 15:56:38.024 gcdInstance[6728:160806] 1---<NSThread: 0x7fad7200cdf0>{number = 1, name = main}
     2018-06-29 15:56:40.026 gcdInstance[6728:160806] 1---<NSThread: 0x7fad7200cdf0>{number = 1, name = main}
     */
}

- (void)selectorBut1 {
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
//    [op start];
    
    /*
     在使用NSBlockOperation的blockOperationWithBlock方法时，结果是和NSInvocationOperation像类似的。
     */
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op start];
    
    /*
     NSBlockOperation使用addExecutionBlock方法后，打印的数据显示了，开辟新的线程了。还有问题是blockOperationWithBlock方法中打印线程也不是主线程。现在能得出来结论就是NSBlockOperation在添加多个addExecutionBlock方法后。系统就会开启多个线程。
     */
}

- (void)selectorBut2 {
    TYOperation *op = [[TYOperation alloc] init];
    [op start];
}

- (void)selectorBut3 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation1) object:nil];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [queue addOperation:op];
    [queue addOperation:op1];
    [queue addOperation:op3];
    
    /*
     NSOperationQueue加NSOperation的子类默认的情况下是执行异步并发队列。这里打印的结果就这样的。
     */
}

- (void)invocationOperation1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"add1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)invocationOperation2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"add2---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)selectorBut4 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 1;//此属性是用来设置是否并发，只有为1的时候为串行。
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"add2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    /*
     NSOperationQueue是用来执行什么队列的，队列分为串行和并发。串行是一个接一个，并发是一个无序执行的。
     */
}

- (void)selectorBut5 {
    
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
