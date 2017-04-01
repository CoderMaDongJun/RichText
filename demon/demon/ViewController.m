//
//  ViewController.m
//  demon
//
//  Created by MDJ on 2017/3/29.
//  Copyright © 2017年 MDJ. All rights reserved.
//

#import "ViewController.h"
#import "XYMakeAttrbutiStringTool.h"
#import "XYContentTextView.h"
#import "XYAttrWebViewController.h"

@interface ViewController ()
/** 展示控件 */
@property (weak, nonatomic) IBOutlet XYContentTextView *contentView;
/** 富文本工具 */
@property (nonatomic ,strong) XYMakeAttrbutiStringTool *attrTool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // testString  [抠鼻屎]从bundle的emoji info.plist内拿出
    NSString *testString =@"[抠鼻屎]aoiasdf你好吗?[抠鼻屎]我不好偶@夏明，你的，#小明#读的的的的按视频否爱上,你能做出来吗,你好[得意地笑]哈大的[纠结],http://www.sina.com,一切都好http://www.baidu.com我的元爱的";
    XYMakeAttrbutiStringTool *attrTool =[[XYMakeAttrbutiStringTool alloc] initWithText:testString fontSize:0 lineSpace:16 paragraphSpace:10 textColor:nil highlightedColor:nil calculateRectWithMaxWidth:self.contentView.frame.size.width];
    self.attrTool = attrTool;
    // url
    self.contentView.specialUrlBeenClickedBlock = ^(NSString *url){
        NSLog(@"url:%@",url);
        XYAttrWebViewController *webController = [[XYAttrWebViewController alloc] init];
        webController.url = url;
        [self presentViewController:webController animated:YES completion:nil];
    };
    // #
    self.contentView.specialJingHaoBeenClickedBlock = ^(NSString *jingHao){
        NSLog(@"jingHao:%@",jingHao);
    };
    // @
    self.contentView.specialAtBeenClickedBlock = ^(NSString *at){
        NSLog(@"at:%@",at);
    };
    self.contentView.attributedText = self.attrTool.attributedText;
}

#pragma mark - 重新设置展示控件的frame
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGSize size = self.attrTool.attributedSize;
    CGPoint point = self.contentView.frame.origin;
    self.contentView.frame = (CGRect){point,size};
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

@end
