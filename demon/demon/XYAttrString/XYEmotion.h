//
//  XYEmotion.h
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

@end
