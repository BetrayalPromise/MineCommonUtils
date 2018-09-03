//
//  NSObject+Bundle.h
//  A
//
//  Created by LiChunYang on 4/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BundleType) {
        /// 系统类
    BundleTypeSystem,
        /// 自定义和第三方类
    BundleTypeCustom,
};

@interface NSObject (Bundle)

+ (BundleType)belongsRelation;

@end
