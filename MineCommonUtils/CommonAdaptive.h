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
    DesignTemplate_414_896 = 5
};

typedef NS_ENUM(NSUInteger, AdaptiveRefer) {
    /// 按X轴
    AdaptiveReferRatioX,
    /// 按Y轴
    AdaptiveReferRatioY,
};

/// 逻辑屏幕分辨率
typedef struct LogicSize {
    CGFloat dpi_320_568;
    CGFloat dpi_375_667;
    CGFloat dpi_375_812;
    CGFloat dpi_414_736;
    CGFloat dpi_414_896;
} LogicSize;

/// 缺省是按照iPhone X标准处理
extern void setTemplate(DesignTemplate dt);
/// 针对不同设备类型均不同时特殊处理
extern CGFloat widgetCustomAdaptive(void(^closure)(LogicSize * s));

/**
 字体大小适配针对3种屏幕宽度的处理

 @param value 设计字体大小
 @param s 比例
 @return 根据比例适配大小
 */
extern CGFloat widgetFontAdaptive(CGFloat value, NSString * s);

extern CGFloat widgetXValueAdaptive(CGFloat value, NSString * s);
extern CGFloat widgetYValueAdaptive(CGFloat value, NSString * s);
