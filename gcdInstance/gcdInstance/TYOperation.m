//
//  TYOperation.m
//  gcdInstance
//
//  Created by 汤义 on 2018/6/29.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYOperation.h"

@implementation TYOperation
-(void)main {
    /*
     要实现取消的功能，我们需要自己在线程的main函数中定期检查isCancelled状态来判断线程是否需要退出，当isCancelled为YES的时候，我们手动退出。
     */
    if (!self.isCancelled) {//是否
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}
@end
