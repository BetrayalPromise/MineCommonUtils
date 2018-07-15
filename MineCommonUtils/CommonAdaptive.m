//
//  CommonAdaptive.m
//  BestLayout
//
//  Created by 李阳 on 23/1/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "CommonAdaptive.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIScreen.h>

@implementation CommonAdaptive

- (instancetype)init {
    self = [super init];
    if (self) {
        _designTemplate = DesignTemplateInch47;
    }
    return self;
}

+ (instancetype _Nonnull)sharedInstance {
    static dispatch_once_t onceToken;
    static CommonAdaptive *instance = nil;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[[self class] alloc] init];
        }
    });
    return instance;
}

+ (CGFloat)widgetCustomAdaptive:(void (^_Nonnull)(DeviceSize *_Nonnull size))closure {
    CGSize size = [self deviceSize];
    DeviceSize *deviceSize = [DeviceSize new];
    closure(deviceSize);
    NSAssert(deviceSize.inch35 != -MAXFLOAT, @"size 35 must be set");
    NSAssert(deviceSize.inch40 != -MAXFLOAT, @"size 40 must be set");
    NSAssert(deviceSize.inch47 != -MAXFLOAT, @"size 47 must be set");
    NSAssert(deviceSize.inch55 != -MAXFLOAT, @"size 55 must be set");
    NSAssert(deviceSize.inch58 != -MAXFLOAT, @"size 58 must be set");
    if (size.width == 320 && size.height == 480) {
        return deviceSize.inch35;
    } else if (size.width == 320 && size.height == 568) {
        return deviceSize.inch40;
    } else if (size.width == 375 && size.height == 667) {
        return deviceSize.inch47;
    } else if (size.width == 414 && size.height == 736) {
        return deviceSize.inch55;
    } else if (size.width == 375 && size.height == 812) {
        return deviceSize.inch58;
    }
    NSAssert(NO, @"not support iPhone size");
    return 0;
}

+ (CGSize)deviceSize {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

+ (CGFloat)widgetFontAdaptive:(AdaptiveFont)type size:(CGFloat)size {
    CGSize deviceSize = [self deviceSize];
    CommonAdaptive *adaptive = [CommonAdaptive sharedInstance];
    if (type == AdaptiveFontSelfAdaption) {
        if (adaptive.designTemplate == DesignTemplateInch35 || adaptive.designTemplate == DesignTemplateInch40) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return size;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return size + 2.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return size + 5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch47 || adaptive.designTemplate == DesignTemplateInch58) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return size - 2.5;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return size;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return size + 2.5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch55) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return size - 5;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return size - 2.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return size;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        }
        NSAssert(NO, @"not support iPhone design size");
        return 0.0;
    } else if (type == AdaptiveFontFixation) {
        return size;
    } else if (type == AdaptiveFontCommon) {
        if (adaptive.designTemplate == DesignTemplateInch35 || adaptive.designTemplate == DesignTemplateInch40 || adaptive.designTemplate == DesignTemplateInch47) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568) || (deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return size;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return size * 1.5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch58) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568) || (deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return size / 1.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return size;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        }
        NSAssert(NO, @"not support iPhone size");
        return 0.0;
    }
    NSAssert(NO, @"not support iPhone design size");
    return 0.0;
}

+ (CGSize)widgetAdaptive:(AdaptiveRefer)type size:(CGSize)size rate:(CGFloat)rate trim:(CGFloat)trim {
    CGSize deviceSize = [self deviceSize];
    CGSize templateSize = [self designTemplateSize];
    NSAssert([self isSupportDeviceSize] != NO, @"unsupport iPhone device size");
    if (type == AdaptiveReferFixation) {
        return size;
    } else if (type == AdaptiveReferRatioX) {
        CGFloat w = (size.width * deviceSize.width / (1.0 * templateSize.width)) * rate + trim;
        CGFloat h = (size.height * deviceSize.width / (1.0 * templateSize.width)) * rate + trim;
        return CGSizeMake(w, h);
    } else if (type == AdaptiveReferRatioY) {
        CGFloat w = (size.width * deviceSize.height / (1.0 * templateSize.height)) * rate + trim;
        CGFloat h = (size.height * deviceSize.height / (1.0 * templateSize.height)) * rate + trim;
        return CGSizeMake(w, h);
    } else {
        NSAssert(NO, @"not support image adaptive type");
        return CGSizeZero;
    }
}

+ (CGSize)widgetAdaptive:(AdaptiveRefer)type size:(CGSize)size rate:(CGFloat)rate {
    return [self widgetAdaptive:type size:size rate:rate trim:0.0];
}

+ (CGSize)widgetAdaptive:(AdaptiveRefer)type size:(CGSize)size trim:(CGFloat)trim {
    return [self widgetAdaptive:type size:size rate:1.0 trim:trim];
}

+ (CGSize)widgetAdaptive:(AdaptiveRefer)type size:(CGSize)size {
    return [self widgetAdaptive:type size:size rate:1.0 trim:0.0];
}

+ (NSArray<NSValue *> *)iPhonesDeviceSize {
    return @[ @(CGSizeMake(320, 480)), @(CGSizeMake(320, 568)), @(CGSizeMake(375, 667)), @(CGSizeMake(414, 736)), @(CGSizeMake(375, 812)) ];
}

+ (CGFloat)widgetAdaptive:(AdaptiveRefer)type value:(CGFloat)value rate:(CGFloat)rate trim:(CGFloat)trim {
    CGSize deviceSize = [self deviceSize];
    CGSize templateSize = [self designTemplateSize];
    NSAssert([self isSupportDeviceSize] != NO, @"unsupport iPhone device size");
    if (type == AdaptiveReferFixation) {
        return value * rate + trim;
    } else if (type == AdaptiveReferRatioX) {
        return (value * deviceSize.width / templateSize.width) * rate + trim;
    } else if (type == AdaptiveReferRatioY) {
        return (value * deviceSize.height / templateSize.height) * rate + trim;
    } else {
        NSAssert(NO, @"not support image adaptive type");
        return 0.0;
    }
}

+ (CGFloat)widgetAdaptive:(AdaptiveRefer)type value:(CGFloat)value rate:(CGFloat)rate {
    return [self widgetAdaptive:type value:value rate:rate trim:0.0];
}

+ (CGFloat)widgetAdaptive:(AdaptiveRefer)type value:(CGFloat)value trim:(CGFloat)trim {
    return [self widgetAdaptive:type value:value rate:1.0 trim:trim];
}

+ (CGFloat)widgetAdaptive:(AdaptiveRefer)type value:(CGFloat)value {
    return [self widgetAdaptive:type value:value rate:1.0 trim:0.0];
}

/// 设计模版尺寸
+ (CGSize)designTemplateSize {
    CommonAdaptive *adaptive = [CommonAdaptive sharedInstance];
    CGSize templateSize = CGSizeZero;
    if (adaptive.designTemplate == DesignTemplateInch35) {
        templateSize = CGSizeMake(320.0, 480.0);
    } else if (adaptive.designTemplate == DesignTemplateInch40) {
        templateSize = CGSizeMake(320.0, 568.0);
    } else if (adaptive.designTemplate == DesignTemplateInch47) {
        templateSize = CGSizeMake(375.0, 667.0);
    } else if (adaptive.designTemplate == DesignTemplateInch55) {
        templateSize = CGSizeMake(414.0, 736.0);
    } else if (adaptive.designTemplate == DesignTemplateInch58) {
        templateSize = CGSizeMake(375.0, 812.0);
    } else {
        templateSize = CGSizeZero;
    }
    if (templateSize.width == 0 && templateSize.height == 0) {
        NSAssert(NO, @"not support design size");
    }
    return templateSize;
}

/// 是否为iPhone设备尺寸
+ (BOOL)isSupportDeviceSize {
    CGSize templateSize = [self designTemplateSize];
    BOOL isContain = NO;
    for (NSValue *value in [self iPhonesDeviceSize]) {
        if ([value isEqualToValue:@(templateSize)]) {
            isContain = YES;
            break;
        }
        isContain = NO;
        continue;
    }
    return isContain;
}

@end


@implementation DeviceSize

- (instancetype)init {
    self = [super init];
    if (self) {
        _inch35 = -MAXFLOAT;
        _inch40 = -MAXFLOAT;
        _inch47 = -MAXFLOAT;
        _inch55 = -MAXFLOAT;
        _inch58 = -MAXFLOAT;
    }
    return self;
}

@end
