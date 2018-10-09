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
    if (r == AdaptiveReferFixation) {
        return value * rate + trim;
    } else if (r == AdaptiveReferRatioX) {
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
    if (r == AdaptiveReferFixation) {
        return size;
    } else if (r == AdaptiveReferRatioX) {
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


extern CGFloat widgetFontAdaptive(CGFloat font, CGFloat rate) {
    if (rate == 0) {
        assert(false);
    }
    CGSize size = deviceSize();

    if (standard_design_template == DesignTemplate_320_568) {
        if (size.width == 320) {
            return font;
        } else if (size.width == 375) {
            return font * rate;
        } else if (size.width == 414) {
            return font * rate * rate;
        } else {
            assert(false);
        }
    } else if (standard_design_template == DesignTemplate_375_667 || standard_design_template == DesignTemplate_375_812) {
        if (size.width == 320) {
            return font * 1.0 / rate;
        } else if (size.width == 375) {
            return font;
        } else if (size.width == 414) {
            return font * rate;
        } else {
            assert(false);
        }
    } else if (standard_design_template == DesignTemplate_414_736 || standard_design_template ==DesignTemplate_414_896) {
        if (size.width == 320) {
            return font * 1.0 / (rate * rate);
        } else if (size.width == 375) {
            return font * 1.0 / rate;
        } else if (size.width == 414) {
            return font;
        } else {
            assert(false);
        }
    } else {
        assert(false);
    }

    return 0.0;
}


