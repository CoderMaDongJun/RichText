//
//  XYContentTextView.h
//  demon
//
//  Created by MDJ on 2017/3/31.
//  Copyright © 2017年 MDJ. All rights reserved.
//  用来显示星云用户“发表心情”正文的textView

#import <UIKit/UIKit.h>

@interface XYContentTextView : UITextView
/** 网址被点击 */
@property (nonatomic ,copy,nullable) void(^specialUrlBeenClickedBlock)(NSString *__nullable urlString);
/** @被点击 */
@property (nonatomic ,copy,nullable) void(^specialAtBeenClickedBlock)(NSString *__nullable atString);
/** #被点击 */
@property (nonatomic ,copy,nullable) void(^specialJingHaoBeenClickedBlock)(NSString *__nullable jingHaoString);
@end
