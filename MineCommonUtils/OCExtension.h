//
//  OCExtension.h
//  A
//
//  Created by 李阳 on 29/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>

#define defer \
    autoreleasepool {} __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

void blockCleanUp(__strong void (^ *block)(void));


