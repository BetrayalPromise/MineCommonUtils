//
//  MessageTrash.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "MessageTrash.h"
#import <objc/runtime.h>

@implementation MessageTrash

static void instanceRealizationFunction(id obj, SEL _cmd) {
    
}

static void classRealizationFunction(id obj, SEL _cmd) {
    
}

+ (instancetype)instanceSource:(Class)source selector:(SEL)selector {
    MessageTrash * mt = [MessageTrash new];
    class_addMethod(self, selector, (IMP)instanceRealizationFunction, "v@:");
#ifdef DEBUG
    NSLog(@"unrecognized instance selector: -[%@ %@]", source, NSStringFromSelector(selector));
#endif
    return mt;
}

+ (instancetype)classSource:(Class)source selector:(SEL)selector {
    MessageTrash * mt = [MessageTrash new];
    class_addMethod(objc_getMetaClass(NSStringFromClass(self).UTF8String), selector, (IMP)classRealizationFunction, "v@:");
#ifdef DEBUG
    NSLog(@"unrecognized class selector: -[%@ %@]", source, NSStringFromSelector(selector));
#endif
    return mt;
}

@end
