//
//  XYEmotion.m
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYEmotion.h"
#import "MJExtension.h"

@implementation XYEmotion
MJCodingImplementation

/**
 *  常用来比较两个XYEmotion对象是否一样
 *
 *  @param other 另外一个XYEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(XYEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}


@end
