//
//  CommonAdaptive.h
//  BestLayout
//
//  Created by 李阳 on 23/1/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, DesignTemplate) {
    DesignTemplate_320_568 = 1,
    DesignTemplate_375_667 = 2,
    DesignTemplate_375_812 = 3,
    DesignTemplate_414_736 = 4,
    DesignTemplate_414_896 = 5,

    DesignTemplate_768_1024 = 6,
    DesignTemplate_834_1112 = 6,
    DesignTemplate_1024_1366 = 7,
};

typedef NS_ENUM(NSUInteger, AdaptiveRefer) {
    AdaptiveReferRatioX,    /// 按X轴
    AdaptiveReferRatioY,    /// 按Y轴
};

/// 缺省是按照iPhone X标准处理
extern void setTemplate(DesignTemplate dt);

/**

 字体大小适配针对3种屏幕宽度的处理 320 375 414 三种屏幕宽度

 @param value 设计值
 @param s 比例 @"1.0:1.5:1.5"
 @return 适配字体
 */
extern CGFloat widgetFontAdaptive(CGFloat value, NSString * s);

/**

 控件相对于屏幕X轴的比例 紧凑型设备有 320 375 414 三种屏幕宽度 不对iPad设备进行处理

 @param value 设计值
 @param s 比例 @"1.0:1.5:1.5"
 @return 适配字体
 */
extern CGFloat widgetXAdaptive(CGFloat value, NSString * s);

/**

 控件相对于屏幕Y轴的比例 紧凑型设备有 568 667 736 812 896 五种屏幕高度 不对iPad设备进行处理

 @param value 设计值
 @param s 比例 @"1.0:1.0:1.0:1.0:1.0"
 @return 适配字体
 */
extern CGFloat widgetYAdaptive(CGFloat value, NSString * s);
