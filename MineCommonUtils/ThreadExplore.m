//
//  ViewController.m
//  UIView+Safe
//
//  Created by 李阳 on 30/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "ThreadExplore.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <pthread.h>

@interface ThreadExplore ()

@property (nonatomic, assign, class) uint64_t threadId;

@end

@implementation ThreadExplore

+ (void)setThreadId:(uint64_t)threadId {
    objc_setAssociatedObject(self, @selector(threadId), @(threadId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (uint64_t)threadId {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) unsignedLongLongValue] : 0;
}

static void replace(Class cls, NSString *selectorName);
static void replaceForwardInvocation(id self, SEL selector, NSInvocation *invocation);

static void replace(Class cls, NSString *selectorName) {
    SEL selector = NSSelectorFromString(selectorName);
    Method method = class_getInstanceMethod(cls, selector);
    const char *typeDescription = (char *) method_getTypeEncoding(method);

    IMP originalImp = class_getMethodImplementation(cls, selector);
    /// 调用直接走消息转发
    IMP msgForwardIMP = _objc_msgForward;

    if (typeDescription[0] == '{') {
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:typeDescription];
        if ([methodSignature.debugDescription rangeOfString:@"is special struct return? YES"].location != NSNotFound) {
            msgForwardIMP = (IMP) _objc_msgForward_stret;
        }
    }
    class_replaceMethod(cls, selector, msgForwardIMP, typeDescription);
    if (class_getMethodImplementation(cls, @selector(forwardInvocation:)) != (IMP) replaceForwardInvocation) {
        class_replaceMethod(cls, @selector(forwardInvocation:), (IMP) replaceForwardInvocation, typeDescription);
    }

    if (class_respondsToSelector(cls, selector)) {
        NSString *originalSelectorName = [NSString stringWithFormat:@"ORIGIN_%@", selectorName];
        SEL originalSelector = NSSelectorFromString(originalSelectorName);
        if (!class_respondsToSelector(cls, originalSelector)) {
            class_addMethod(cls, originalSelector, originalImp, typeDescription);
        }
    }
}

static void replaceForwardInvocation(id self, SEL selector, NSInvocation *invocation) {
    pthread_t thread_t = pthread_self();
    uint64_t tid;
    pthread_threadid_np(thread_t, &tid);

    if (tid != ThreadExplore.threadId) {
        NSLog(@"-[%@ %@] not run at thread which thread Id %llu", self, NSStringFromSelector(selector), tid);
        NSLog(@"%@", [NSThread callStackSymbols]);
    }

    NSString *selectorName = NSStringFromSelector(invocation.selector);
    NSString *origSelectorName = [NSString stringWithFormat:@"ORIGIN_%@", selectorName];
    SEL origSelector = NSSelectorFromString(origSelectorName);
    invocation.selector = origSelector;
    [invocation invoke];
}

+ (void)checkClass:(Class)aClass executeSelector:(SEL)selector threadId:(uint64_t)threadId {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    ThreadExplore.threadId = threadId;

    NSString * selectorName = NSStringFromSelector(selector);
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(aClass, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        if ([methodName isEqualToString:selectorName]) {
            replace(aClass, methodName);
            break;
        }
    }
    free(methodList);

    dispatch_semaphore_signal(semaphore);
}

@end
