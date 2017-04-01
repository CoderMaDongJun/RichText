//
//  XYEmotionTool.h
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//



#import <Foundation/Foundation.h>

@class XYEmotion;

@interface XYEmotionTool : NSObject
+ (void)addRecentEmotion:(XYEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (XYEmotion *)emotionWithChs:(NSString *)chs;


@end
