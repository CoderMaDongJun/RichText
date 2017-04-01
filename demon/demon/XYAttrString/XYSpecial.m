//
//  XYSpecial.m
//  demon
//
//  Created by MDJ on 2017/3/30.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "XYSpecial.h"

@implementation XYSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
