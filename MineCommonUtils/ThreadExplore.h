//
//  ViewController.h
//  UIView+Safe
//
//  Created by 李阳 on 30/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadExplore : NSObject

@property (nonatomic, assign, class, readonly) uint64_t threadId;
/**
 检测选择子是否在指定线程上运行

 @param aClass 类
 @param selector 选择子 
 @param threadId POSIX线程号
 */
+ (void)checkClass:(Class)aClass executeSelector:(SEL)selector threadId:(uint64_t)threadId;

@end
