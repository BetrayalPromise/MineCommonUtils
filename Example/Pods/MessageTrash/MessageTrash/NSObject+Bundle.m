//
//  NSObject+Bundle.m
//  A
//
//  Created by LiChunYang on 4/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSObject+Bundle.h"

@implementation NSObject (Bundle)

+ (BundleType)belongsRelation {
    NSString * currentBundlePath = [NSBundle bundleForClass:self].bundlePath;
    NSString * mainBundlePath = [NSBundle mainBundle].bundlePath;
    if ([currentBundlePath containsString:mainBundlePath]) {
        return BundleTypeCustom;
    } else {
        return BundleTypeSystem;
    }
}

@end
