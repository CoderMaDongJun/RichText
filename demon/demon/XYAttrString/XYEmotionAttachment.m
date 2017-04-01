//
//  XYEmotionAttachment.m
//  demon
//
//  Created by MDJ on 2017/3/30.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYEmotionAttachment.h"
#import "XYEmotion.h"

@implementation XYEmotionAttachment

- (void)setEmotion:(XYEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
