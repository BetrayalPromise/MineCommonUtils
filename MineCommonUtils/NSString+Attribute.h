//
//  NSString+Attributed.h
//  Demo
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 创建字符串 GCC支持
#define GCCString(fmt, arg...) [NSString stringWithFormat:fmt, ##arg]
/// 创建字符串 C99支持
#define C99String(fmt, ...) [NSString stringWithFormat:fmt, __VA_ARGS__]

@interface NSString (Attribute)

@property (nonatomic, weak, readonly) NSMutableAttributedString * attributedText;

@end
