//
//  GCD.m
//  GCDExtension
//
//  Created by 李阳 on 26/10/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "GCD.h"
#import <pthread.h>

DISPATCH_EXPORT void dispatch_main_sync(dispatch_block_t block) {
    if (pthread_main_np() != 0) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

DISPATCH_EXPORT void dispatch_main_async(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

DISPATCH_EXPORT void dispatch_main_execute(dispatch_block_t block) {
    if (pthread_main_np() != 0) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
