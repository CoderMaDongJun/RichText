//
//  XYContentTextView.m
//  demon
//
//  Created by MDJ on 2017/3/31.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYContentTextView.h"
#import "XYSpecial.h"

#define XYStatusTextViewCoverTag 1024
#define XYSelectRangeColor [UIColor colorWithRed:204 green:204 blue:204 alpha:1]// 特殊文字选中的颜色

@implementation XYContentTextView
{
    NSString * _specialContent;// 点击的特殊文字，判断url、@、#
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.editable = NO;
    self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    // 禁止滚动, 让文字完全显示出来
    self.scrollEnabled = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 触摸对象
    UITouch *touch = [touches anyObject];
    
    // 触摸点
    CGPoint point = [touch locationInView:self];
    
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    BOOL contains = NO;
    
    for (XYSpecial *special in specials) {
        self.selectedRange = special.range;
        // 获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                contains = YES;
                break;
            }
        }
        
        if (contains) {
            for (UITextSelectionRect *selectionRect in rects) {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;
                
                UIView *cover = [[UIView alloc] init];
                cover.backgroundColor = XYSelectRangeColor;
                cover.frame = rect;
                cover.tag = XYStatusTextViewCoverTag;
                cover.layer.cornerRadius = 2;
                [self insertSubview:cover atIndex:0];
                
            }
            _specialContent = special.text;
            break;
        }else{
            _specialContent = nil;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jumpToWebViewWithUrl:_specialContent];// 跳转到相应的网址
        
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews) {
        if (child.tag == XYStatusTextViewCoverTag) [child removeFromSuperview];
    }
}

#pragma mark - 特殊字符串被点击跳转到网页
- (void)jumpToWebViewWithUrl:(NSString *)specialText
{
    if (specialText == nil) return;
    
    if ([specialText hasPrefix:@"#"]&&[specialText hasSuffix:@"#"]&&self.specialJingHaoBeenClickedBlock) {// #
        self.specialJingHaoBeenClickedBlock(specialText);
    }else if ([specialText hasPrefix:@"@"] &&self.specialAtBeenClickedBlock) {// @
        self.specialAtBeenClickedBlock(specialText);
    }else if (self.specialUrlBeenClickedBlock && ([specialText containsString:@"http"] || [specialText containsString:@"www."]||[specialText containsString:@"ftp"])) {// url协议较多，视情况而定
        self.specialUrlBeenClickedBlock(specialText);
    }
}


@end
