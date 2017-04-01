//
//  MDJAttrbutiString.h
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//  根据普通字符串 --> 富文本字符串

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYMakeAttrbutiStringTool : NSObject
- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace textColor:(UIColor *)color highlightedColor:(UIColor *)lightedColor calculateRectWithMaxWidth:(CGFloat)maxWidth;

/**	最终计算的富文本,带有属性的(特殊文字会高亮显示\显示表情)*/
@property (nonatomic, copy,readonly) NSAttributedString *attributedText;
/**	富文本的rect*/
@property (nonatomic, assign,readonly) CGSize attributedSize;

@end
