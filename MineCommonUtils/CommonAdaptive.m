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
extern void setTemplate(DesignTemplate dt);

static DesignTemplate standard_design_template = DesignTemplate_375_812;

extern void setTemplate(DesignTemplate dt) {
    standard_design_template = dt;
}

static CGSize deviceSize() {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

extern CGFloat widgetFontAdaptive(CGFloat value, NSString * s) {
    return widgetXAdaptive(value, s);
}

extern CGFloat widgetXAdaptive(CGFloat value, NSString * s) {
    CGSize size = deviceSize();
    if (size.width == 768 ||  size.width == 834 || size.width == 1024) {
        return value;
    }
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
    if (size.width == 768 ||  size.width == 834 || size.width == 1024) {
        return value;
    }
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
