//
//  NSObject+Message.m
//  A
//
//  Created by LiChunYang on 4/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSObject+UnknowMessage.h"
#import "MessageTrash.h"
#import <objc/message.h>

@implementation NSObject (UnknowMessage)

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    NSString * selString = NSStringFromSelector([anInvocation selector]);
//    NSString * clsString = NSStringFromClass([self class]);
//    MessageTrash * mt = [MessageTrash new];
//    [anInvocation setTarget:mt];
//    [anInvocation setSelector:@selector(messageSource:unknowSelectorName:)];
//    [anInvocation setArgument:&clsString atIndex:2];
//    [anInvocation setArgument:&selString atIndex:3];
//    [anInvocation invokeWithTarget:mt];
//}
//#pragma clang diagnostic pop
//
//- (NSMethodSignature *)exchange_methodSignatureForSelector:(SEL)aSelector {
//    if ([[self class] belongsRelation] == BundleTypeSystem) {
//        NSLog(@"class: \"%@\" function: \"%@\"", NSStringFromClass([self class]), NSStringFromSelector(aSelector));
//        return [self exchange_methodSignatureForSelector:aSelector];
//    }
//    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];
//}

+ (void)safeGuardUnrecognizedSelector {
    if (YES) {
        Class cls = [self class];
        Method origMethod = class_getInstanceMethod(cls, @selector(forwardingTargetForSelector:));
        SEL origsel = @selector(forwardingTargetForSelector:);
        Method swizMethod = class_getInstanceMethod(cls, @selector(instance_forwardingTargetForSelector:));
        SEL swizsel = @selector(instance_forwardingTargetForSelector:);
        BOOL addMehtod = class_addMethod(cls, origsel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
        if (addMehtod) {
            class_replaceMethod(cls, swizsel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, swizMethod);
        }
    }
    if (YES) {
        Class metaCls = objc_getMetaClass(NSStringFromClass(self).UTF8String);
        Method origMethod = class_getClassMethod(metaCls, @selector(forwardingTargetForSelector:));
        SEL origsel = @selector(forwardingTargetForSelector:);
        Method swizMethod = class_getClassMethod(metaCls, @selector(class_forwardingTargetForSelector:));
        SEL swizsel = @selector(class_forwardingTargetForSelector:);
        BOOL addMehtod = class_addMethod(metaCls, origsel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
        if (addMehtod) {
            class_replaceMethod(metaCls, swizsel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, swizMethod);
        }
    }
}

- (id)instance_forwardingTargetForSelector:(SEL)aSelector {
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || signature) {
        return [self instance_forwardingTargetForSelector:aSelector];
    }
    return [MessageTrash instanceSource:[self class] selector:aSelector];
}

+ (id)class_forwardingTargetForSelector:(SEL)aSelector {
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || signature) {
        return [self class_forwardingTargetForSelector:aSelector];
    }
    return [MessageTrash classSource:[self class] selector:aSelector];
}

@end
