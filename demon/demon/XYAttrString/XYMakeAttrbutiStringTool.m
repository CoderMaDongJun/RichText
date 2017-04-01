//
//  MDJAttrbutiString.m
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYMakeAttrbutiStringTool.h"
#import "RegexKitLite.h"
#import "XYTextPart.h"
#import "XYSpecial.h"
#import "XYEmotionTool.h"
#import "XYEmotion.h"

@implementation XYMakeAttrbutiStringTool
{
    // 字号 default 15
    CGFloat _attrFontSize;
    // 行高 default 3
    CGFloat _attrLineSpace;
    // 段间距 default 5
    CGFloat _attrParagraphSpace;
    // 普通文字颜色 default blackColor
    UIColor *_attrTextColor;
    // 特殊文字颜色 default blueColor
    UIColor *_attrTextLightedColor;
    // 计算允许最大宽度 default 屏幕宽度
    CGFloat _attrMaxWidth;
    // 富文本frame
    CGRect _attrRect ;
}
- (instancetype)initWithText:(NSString *)text
{
    return [self initWithText:text fontSize:0 lineSpace:0 paragraphSpace:0 textColor:nil highlightedColor:nil calculateRectWithMaxWidth:0];
}

- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace textColor:(UIColor *)color highlightedColor:(UIColor *)lightedColor calculateRectWithMaxWidth:(CGFloat)maxWidth{
    if (self = [super init]) {
        _attrFontSize = fontSize>0?fontSize:15;
        _attrLineSpace = lineSpace>0?lineSpace:2;
        _attrParagraphSpace = paragraphSpace>0?paragraphSpace:5;
        _attrTextColor = color?color:[UIColor blackColor];
        _attrTextLightedColor = lightedColor?lightedColor:[UIColor colorWithRed:0 green:153 blue:255 alpha:1];
        _attrMaxWidth = maxWidth>0?maxWidth:[UIScreen mainScreen].bounds.size.width;
        // 计算
        _attributedText = [self makeAttributedTextWithContent:text];
        _attrRect = [_attributedText boundingRectWithSize:CGSizeMake(_attrMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    }
    return self;
}

/**
 *  根据普通文本，生成富文本
 *
 *  @prama content 普通文本字符串
 */
- (NSAttributedString *)makeAttributedTextWithContent:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[+-0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    // url链接的规则
    NSString *urlPattern = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XYTextPart *part = [[XYTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XYTextPart *part = [[XYTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    
    // 排序
    [parts sortUsingComparator:^NSComparisonResult(XYTextPart *part1, XYTextPart *part2) {
        return (part1.range.location > part2.range.location)?NSOrderedDescending:NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:_attrFontSize];
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    for (XYTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            XYEmotion *emotion =[XYEmotionTool emotionWithChs:part.text];
            NSString *name = emotion.png;
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName :_attrTextLightedColor
                                                                                       }];
            
            // 创建特殊对象
            XYSpecial *s = [[XYSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            [specials addObject:s];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = _attrLineSpace;
    paragraph.paragraphSpacing = _attrParagraphSpace;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attributedText;
}

- (CGSize)attributedSize{
    return _attrRect.size;
}
@end
