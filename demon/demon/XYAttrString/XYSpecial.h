//
//  XYSpecial.h
//  demon
//
//  Created by MDJ on 2017/3/30.
//  Copyright © 2017年 MDJ. All rights reserved.
//  特殊文字

#import <Foundation/Foundation.h>

@interface XYSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;


@end
