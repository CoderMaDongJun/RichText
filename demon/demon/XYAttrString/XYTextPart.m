//
//  MDJTextPart.m
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYTextPart.h"

@implementation XYTextPart
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
