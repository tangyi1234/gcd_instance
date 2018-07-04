//
//  TYGCDInstanceViewController.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/26.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYGCDInstanceViewController.h"

@interface TYGCDInstanceViewController ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, assign) int votes;
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
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 140, 150, 30);
    but2.backgroundColor = [UIColor blueColor];
    [but2 setTitle:@"新线程执行主队列" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 180, 150, 30);
    but3.backgroundColor = [UIColor orangeColor];
    [but3 setTitle:@"栅栏执行" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    
    UIButton *but4 = [UIButton buttonWithType:UIButtonTypeCustom];
    but4.frame = CGRectMake(10, 220, 150, 30);
    but4.backgroundColor = [UIColor purpleColor];
    [but4 setTitle:@"延时执行" forState:UIControlStateNormal];
    [but4 addTarget:self action:@selector(selectorBut4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but4];
    
    UIButton *but5 = [UIButton buttonWithType:UIButtonTypeCustom];
    but5.frame = CGRectMake(10, 260, 150, 30);
    but5.backgroundColor = [UIColor brownColor];
    [but5 setTitle:@"快速迭代" forState:UIControlStateNormal];
    [but5 addTarget:self action:@selector(selectorBut5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but5];
    
    UIButton *but6 = [UIButton buttonWithType:UIButtonTypeCustom];
    but6.frame = CGRectMake(10, 300, 150, 30);
    but6.backgroundColor = [UIColor magentaColor];
    [but6 setTitle:@"队列组" forState:UIControlStateNormal];
    [but6 addTarget:self action:@selector(selectorBut6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but6];
    
    UIButton *but7 = [UIButton buttonWithType:UIButtonTypeCustom];
    but7.frame = CGRectMake(10, 340, 150, 30);
    but7.backgroundColor = [UIColor yellowColor];
    [but7 setTitle:@"信号量同步" forState:UIControlStateNormal];
    [but7 addTarget:self action:@selector(selectorBut7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but7];
    
    UIButton *but8 = [UIButton buttonWithType:UIButtonTypeCustom];
    but8.frame = CGRectMake(10, 340, 150, 30);
    but8.backgroundColor = [UIColor greenColor];
    [but8 setTitle:@"线程安全" forState:UIControlStateNormal];
    [but8 addTarget:self action:@selector(selectorBut8) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but8];
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
    NSLog(@"开始执行");
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //任务1
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"所处在的线程:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"所处在的线程1:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"所处在的线程:%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"执行完后当前线程:%@",[NSThread currentThread]);
    
    /*
     这里会卡住，这是为什么了？因为我们的所有方法执行都是在我们的主线程来执行的。我们的主线程队列的执行方式是由上往下执行的.当我们的主线程执行到任务1的时候，这是任务1执行是同步主队列。那么这个同步主队列是要等待我们的主线程执行完了才会接着往下走，然而主线程有看这个同步主队列的执行完成。所以导致循环卡死。这里的问题是在同一个线程中用的是同一个队列(这里队列是串型)来做两个任务，所以必然会导致卡死。
     */
}

- (void)selectorBut2 {
    [NSThread detachNewThreadSelector:@selector(selectorBut1) toTarget:self withObject:nil];
    /*
     这里能做到打印执行全部，这是因为我们开辟了一个新的线程。代码是在这个新的线程执行的，当执行到第一任务时，我们这里就执行任务1.因为这里的任务和执行代码的线程是两个线程了，这里就不存在互相等待，出现循环了。
     执行结果：
     2018-07-03 10:43:01.380 gcdInstance[1316:40451] 当前线程:<NSThread: 0x7fa13b52cba0>{number = 2, name = (null)}
     2018-07-03 10:43:01.381 gcdInstance[1316:40451] 开始执行
     2018-07-03 10:43:03.386 gcdInstance[1316:40361] 所处在的线程:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:05.388 gcdInstance[1316:40361] 所处在的线程:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:07.390 gcdInstance[1316:40361] 所处在的线程1:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:09.394 gcdInstance[1316:40361] 所处在的线程1:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:11.398 gcdInstance[1316:40361] 所处在的线程:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:13.402 gcdInstance[1316:40361] 所处在的线程:<NSThread: 0x7fa13b719e00>{number = 1, name = main}
     2018-07-03 10:43:13.402 gcdInstance[1316:40451] 执行完后当前线程:<NSThread: 0x7fa13b52cba0>{number = 2, name = (null)}
     第一个和最后都是打印新的线程。
     */
}

- (void)selectorBut3 {
    NSLog(@"打印当前线程:%@",[NSThread currentThread]);
    
//    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        for (int i = 1; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1 ----:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 1; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 ----:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        for (int i = 1; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"barrier ----:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 1; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3 ----:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 1; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4 ----:%@",[NSThread currentThread]);
        }
    });
    
    /*
     这里的功能就和NSOperation的依赖有点相似，先执行barrier之前任务，在执行后面的任务。
     打印(加了barrier)：
     2018-07-03 11:38:16.255 gcdInstance[1734:68504] 打印当前线程:<NSThread: 0x7fc717d1a4b0>{number = 1, name = main}
     2018-07-03 11:38:18.259 gcdInstance[1734:68528] 1 ----:<NSThread: 0x7fc717c2f560>{number = 3, name = (null)}
     2018-07-03 11:38:18.259 gcdInstance[1734:68529] 2 ----:<NSThread: 0x7fc71a108990>{number = 2, name = (null)}
     2018-07-03 11:38:20.263 gcdInstance[1734:68529] barrier ----:<NSThread: 0x7fc71a108990>{number = 2, name = (null)}
     2018-07-03 11:38:22.265 gcdInstance[1734:68528] 4 ----:<NSThread: 0x7fc717c2f560>{number = 3, name = (null)}
     2018-07-03 11:38:22.265 gcdInstance[1734:68529] 3 ----:<NSThread: 0x7fc71a108990>{number = 2, name = (null)}
     
     打印(不加barrier):
     2018-07-03 11:39:09.091 gcdInstance[1754:69288] 打印当前线程:<NSThread: 0x7fdb0e517530>{number = 1, name = main}
     2018-07-03 11:39:11.093 gcdInstance[1754:69313] 4 ----:<NSThread: 0x7fdb0e84bcb0>{number = 5, name = (null)}
     2018-07-03 11:39:11.093 gcdInstance[1754:69314] 1 ----:<NSThread: 0x7fdb0e4093f0>{number = 2, name = (null)}
     2018-07-03 11:39:11.093 gcdInstance[1754:69311] 3 ----:<NSThread: 0x7fdb0e53ada0>{number = 4, name = (null)}
     2018-07-03 11:39:11.093 gcdInstance[1754:69310] 2 ----:<NSThread: 0x7fdb0eb05a90>{number = 3, name = (null)}
     
     */
}

- (void)selectorBut4 {
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    
    [NSThread sleepForTimeInterval:2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
    /*
     需要注意的是：dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。
     */
}

- (void)selectorBut5 {
    //并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //串行
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    NSLog(@"开始执行");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"迭代线程:%zu,%@",index,[NSThread currentThread]);
    });
    NSLog(@"执行完毕");
    /*
     dispatch_apply就是一个类似for循环的遍历，如果是并发队列是会创建新线程，串行会使用当前线程。执行过程是执行完dispatch_apply后才会进行下面的执行。
     */
}

- (void)selectorBut6 {
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    NSLog(@"开始");
    //并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    //任务1
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"任务1--:%@",[NSThread currentThread]);
        }
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    //任务2
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"任务2--:%@",[NSThread currentThread]);
        }
    });
    
    //加入到队列组中
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //等待两个异步并发队列执行完成，后回到主线程。
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"回到来后的线程:%@",[NSThread currentThread]);
        }
        NSLog(@"到此处");
    });
    
    NSLog(@"这是最后一行");
    /*
     队列组，他的核心作用是等待组队列中队列全部做完，才会执行当前个队列。这里一般指的是主线程。
     */
}

- (void)selectorBut7 {
    NSLog(@"获取当前线程:%@",[NSThread currentThread]);
    NSLog(@"开始执行");
    //并发
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //信号总量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    dispatch_async(queue, ^{
       //追加任务1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务中的线程:%@",[NSThread currentThread]);
        
        number = 100;
        //给信号量加一
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"等待前");
    //通过条件来看是否需要等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"结束执行:%d",number);
    /*
     通过信号量来控制方法的执行顺序
     
     Dispatch Semaphore 提供了三个函数。
     
     dispatch_semaphore_create：创建一个Semaphore并初始化信号的总量
     dispatch_semaphore_signal：发送一个信号，让信号总量加1
     dispatch_semaphore_wait：可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。
     
     注意：信号量的使用前提是：想清楚你需要处理哪个线程等待（阻塞），又要哪个线程继续执行，然后使用信号量。
     */
}

- (void)selectorBut8{
    /*
     线程安全：如果你的代码所在的进程中有多个线程在同时运行，而这些线程可能会同时运行这段代码。如果每次运行结果和单线程运行的结果是一样的，而且其他的变量的值也和预期的是一样的，就是线程安全的。
     
     若每个线程中对全局变量、静态变量只有读操作，而无写操作，一般来说，这个全局变量是线程安全的；若有多个线程同时执行写操作（更改变量），一般都需要考虑线程同步，否则的话就可能影响线程安全。
     
     线程同步：可理解为线程 A 和 线程 B 一块配合，A 执行到一定程度时要依靠线程 B 的某个结果，于是停下来，示意 B 运行；B 依言执行，再将结果给 A；A 再继续操作。
     
     举个简单例子就是：两个人在一起聊天。两个人不能同时说话，避免听不清(操作冲突)。等一个人说完(一个线程结束操作)，另一个再说(另一个线程再开始操作)。
     */
    NSLog(@"打印当前线程:%@",[NSThread currentThread]);
    NSLog(@"开始执行");
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue1",  DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("myQueue2", DISPATCH_QUEUE_SERIAL);
    //信号量
    _semaphore = dispatch_semaphore_create(1);
    //总票数
    self.votes = 50;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [weakSelf ticketWindow];
    });
    
    dispatch_async(queue1, ^{
        [weakSelf ticketWindow];
    });
}

- (void)ticketWindow{
    while (1) {
        /*
         可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程）。这句话的意思是，这个方法会操作信号总量会减一。但要满足操作这个方法必须就要满足总量不为0，如果为0就不会进行操作租塞在这里。在这里用做线程安全操作还因为，它如果租塞就会将(所有的线程都租塞了)。
         */
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        if (self.votes > 0) {
            self.votes --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.votes, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            NSLog(@"售票完毕");
            dispatch_semaphore_signal(_semaphore);
            break;
        }

            dispatch_semaphore_signal(_semaphore);

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
