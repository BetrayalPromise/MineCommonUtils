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

static CGSize deviceSize(void);
static CGSize designTemplateSize(void);
extern void setTemplate(DesignTemplate dt);

static DesignTemplate standard_design_template = DesignTemplate_375_812;

extern void setTemplate(DesignTemplate dt) {
    standard_design_template = dt;
}

extern CGFloat widgetCustomAdaptive(void(^closure)(LogicSize * s)) {
    LogicSize * ls = (LogicSize *)malloc(sizeof(LogicSize));
    ls->dpi_320_568 = ls->dpi_375_667 = ls->dpi_375_812 = ls->dpi_414_736 = ls->dpi_414_896 = 0;
    closure(ls);
    if (ls->dpi_320_568 == 0 || ls->dpi_375_667 == 0 || ls->dpi_375_812 == 0 || ls->dpi_414_736 == 0 || ls->dpi_414_896 == 0) {
        assert(false);
    }
    CGSize size = deviceSize();
    if (size.width == 320 && size.height == 568) {
        CGFloat value = ls->dpi_320_568;
        free(ls);
        return value;
    } else if (size.width == 375 && size.height == 667) {
        CGFloat value = ls->dpi_375_667;
        free(ls);
        return value;
    } else if (size.width == 375 && size.height == 812) {
        CGFloat value = ls->dpi_375_812;
        free(ls);
        return value;
    } else if (size.width == 414 && size.height == 736) {
        CGFloat value = ls->dpi_414_736;
        free(ls);
        return value;
    } else if (size.width == 414 && size.height == 896) {
        CGFloat value = ls->dpi_414_896;
        free(ls);
        return value;
    } else {
        free(ls);
        assert(false);
        return 0.0;
    }
}

extern CGFloat widgetValueAdaptive(AdaptiveRefer r, CGFloat value, CGFloat rate, CGFloat trim) {
    CGSize ds = deviceSize();
    CGSize templateSize = designTemplateSize();
    if (r == AdaptiveReferRatioX) {
        return (value * ds.width / templateSize.width) * rate + trim;
    } else if (r == AdaptiveReferRatioY) {
        return (value * ds.height / templateSize.height) * rate + trim;
    } else {
        assert(false);
        return 0.0;
    }
}


extern CGSize widgetSizeAdaptive(AdaptiveRefer r, CGSize size, CGFloat rate, CGFloat trim) {
    CGSize ds = deviceSize();
    CGSize templateSize = designTemplateSize();
    if (r == AdaptiveReferRatioX) {
        CGFloat w = (size.width * ds.width / (1.0 * templateSize.width)) * rate + trim;
        CGFloat h = (size.height * ds.width / (1.0 * templateSize.width)) * rate + trim;
        return CGSizeMake(w, h);
    } else if (r == AdaptiveReferRatioY) {
        CGFloat w = (size.width * ds.height / (1.0 * templateSize.height)) * rate + trim;
        CGFloat h = (size.height * ds.height / (1.0 * templateSize.height)) * rate + trim;
        return CGSizeMake(w, h);
    } else {
        assert(false);
        return CGSizeZero;
    }
}

static CGSize deviceSize() {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

/// 设计模版尺寸
static CGSize designTemplateSize() {
    CGSize templateSize = CGSizeZero;
    if (standard_design_template == DesignTemplate_320_568) {
        templateSize = CGSizeMake(320.0, 568.0);
    } else if (standard_design_template == DesignTemplate_375_667) {
        templateSize = CGSizeMake(375.0, 667.0);
    } else if (standard_design_template == DesignTemplate_375_812) {
        templateSize = CGSizeMake(375.0, 812.0);
    } else if (standard_design_template == DesignTemplate_414_736) {
        templateSize = CGSizeMake(414.0, 736.0);
    } else if (standard_design_template == DesignTemplate_414_896) {
        templateSize = CGSizeMake(414.0, 896.0);
    } else {
        assert(false);
    }
    return templateSize;
}

extern CGFloat widgetFontAdaptive(CGFloat value, NSString * s) {
    return widgetXValueAdaptive(value, s);
}

extern CGFloat widgetXAdaptive(CGFloat value, NSString * s) {
    CGSize size = deviceSize();
    NSArray * sArray = [s componentsSeparatedByString:@":"];
    if (sArray.count != 3) {
        assert(false);
    }
    CGFloat rate0 = [sArray[0] floatValue];
    CGFloat rate1 = [sArray[1] floatValue];
    CGFloat rate2 = [sArray[2] floatValue];
    if (standard_design_template == DesignTemplate_320_568) {
        if (size.width == 320) {
            return value * rate0 * 1.0 / rate0;
        } else if (size.width == 375) {
            return value * rate1 * 1.0 / rate0;
        } else if (size.width == 414) {
            return value * rate2 * 1.0 / rate0;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_375_667 || standard_design_template == DesignTemplate_375_812) {
        if (size.width == 320) {
            return value * rate0 * 1.0 / rate1;
        } else if (size.width == 375) {
            return value * rate1 * 1.0 / rate1;
        } else if (size.width == 414) {
            return value * rate2 * 1.0 / rate1;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_414_736 || standard_design_template ==DesignTemplate_414_896) {
        if (size.width == 320) {
            return value * rate0 * 1.0 / rate2;
        } else if (size.width == 375) {
            return value * rate1 * 1.0 / rate2;
        } else if (size.width == 414) {
            return value * rate2 * 1.0 / rate2;
        } else {
            assert(false);
            return 0.0;
        }
    } else {
        assert(false);
        return 0.0;
    }
}

extern CGFloat widgetYAdaptive(CGFloat value, NSString * s) {
    CGSize size = deviceSize();
    NSArray * sArray = [s componentsSeparatedByString:@":"];
    if (sArray.count != 5) {
        assert(false);
    }
    CGFloat rate0 = [sArray[0] floatValue];
    CGFloat rate1 = [sArray[1] floatValue];
    CGFloat rate2 = [sArray[2] floatValue];
    CGFloat rate3 = [sArray[2] floatValue];
    CGFloat rate4 = [sArray[2] floatValue];
    
    if (standard_design_template == DesignTemplate_320_568) {
        if (size.height == 568) {
            return value * rate0 * 1.0 / rate0;
        } else if (size.height == 667) {
            return value * rate1 * 1.0 / rate0;
        } else if (size.height == 812) {
            return value * rate2 * 1.0 / rate0;
        } else if (size.height == 736) {
            return value * rate3 * 1.0 / rate0;
        } else if (size.height == 896) {
            return value * rate4 * 1.0 / rate0;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_375_667) {
        if (size.height == 568) {
            return value * rate0 * 1.0 / rate1;
        } else if (size.height == 667) {
            return value * rate1 * 1.0 / rate1;
        } else if (size.height == 812) {
            return value * rate2 * 1.0 / rate1;
        } else if (size.height == 736) {
            return value * rate3 * 1.0 / rate1;
        } else if (size.height == 896) {
            return value * rate4 * 1.0 / rate1;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_375_812) {
        if (size.height == 568) {
            return value * rate0 * 1.0 / rate2;
        } else if (size.height == 667) {
            return value * rate1 * 1.0 / rate2;
        } else if (size.height == 812) {
            return value * rate2 * 1.0 / rate2;
        } else if (size.height == 736) {
            return value * rate3 * 1.0 / rate2;
        } else if (size.height == 896) {
            return value * rate4 * 1.0 / rate2;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_414_736) {
        if (size.height == 568) {
            return value * rate0 * 1.0 / rate3;
        } else if (size.height == 667) {
            return value * rate1 * 1.0 / rate3;
        } else if (size.height == 812) {
            return value * rate2 * 1.0 / rate3;
        } else if (size.height == 736) {
            return value * rate3 * 1.0 / rate3;
        } else if (size.height == 896) {
            return value * rate4 * 1.0 / rate3;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == DesignTemplate_414_896) {
        if (size.height == 568) {
            return value * rate0 * 1.0 / rate4;
        } else if (size.height == 667) {
            return value * rate1 * 1.0 / rate4;
        } else if (size.height == 812) {
            return value * rate2 * 1.0 / rate4;
        } else if (size.height == 736) {
            return value * rate3 * 1.0 / rate4;
        } else if (size.height == 896) {
            return value * rate4 * 1.0 / rate4;
        } else {
            assert(false);
            return 0.0;
        }
    } else {
        assert(false);
        return 0.0;
    }
}
