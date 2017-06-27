//
//  ViewController.m
//  TextClick
//
//  Created by apple on 17/6/23.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "ViewController.h"
#define font 17

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (assign, nonatomic) BOOL isSelect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self protocolIsSelect:self.isSelect];

}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请遵守以下协议《支付宝协议》《微信协议》《建行协议》《招行协议》《中国银行协议》《上海银行协议》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"《支付宝协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《微信协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《建行协议》"]];
    
    
    UIImage *image = [UIImage imageNamed:select == YES ? @"播放" : @"播放显示"];
    CGSize size = CGSizeMake(font , font);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = resizeImage;
    NSMutableAttributedString *imageString = [[NSMutableAttributedString attributedStringWithAttachment:textAttachment] mutableCopy];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    [attributedString insertAttributedString:imageString atIndex:0];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];
    _textview.attributedText = attributedString;
    _textview.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textview.delegate = self;
    _textview.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textview.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"建行支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"支付宝支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
        NSLog(@"微信支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
