//
//  ViewController.m
//  TGTNPopupDemo
//
//  Created by Mac on 2022/5/10.
//

#import "ViewController.h"

#import "TGTNPopupBaseView.h"
#import "TGTNPopupDefaultView.h"
#import "TGTNPopupLineDefaultView.h"
#import "TGTNPopupCloseView.h"

@interface ViewController ()
/// 弹出类型
@property (nonatomic, assign) NSInteger type;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100.0)/2.0, ([UIScreen mainScreen].bounds.size.height - 100.0)/2.0, 100.0, 100.0);
    button.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *) button {
    TGTNPopupCloseView *popupView = [TGTNPopupCloseView new];
    popupView.tgtnShowPopupController = self;
    popupView.tgtnBackObject = [UIColor purpleColor];
    popupView.tgtnBackCornerRadius = 10.0;
    popupView.tgtnBackPoint = CGPointMake(30.0, -34.0);
    popupView.tgtnPositionType = TGTNPopupPositionTypeDefault;
    
    popupView.titlePoint = CGPointMake(20.0, 44.0);
    popupView.titleObject = @"和懂你的人一起分享此刻的心情吧~";
    popupView.titleAlignment = NSTextAlignmentLeft;
    popupView.titleFont = [UIFont boldSystemFontOfSize:16.0];
    popupView.contentPoint = CGPointMake(20.0, 15);
    popupView.contentObject = @"1.滴滴速配是智能系统根据您当前的兴趣喜好为您找到最佳交友匹配对象的新鲜玩法。\n2.智能系统会随机快速匹配一句搭讪的话，帮您解决开场白。当然您也可以自己编辑聊天方式，和所匹配到的稀又进行对话。";
    popupView.contentFont = [UIFont boldSystemFontOfSize:13.0];
    popupView.btnContentObject = @"X";
    
    popupView.buttonSize = CGSizeMake(15.0, 15.0);
    popupView.bottomSpacing = 40.0;
    
    __weak typeof(self) weakSelef = self;
    popupView.tgtnBlankClosedClickConfig = ^{
        __strong typeof(weakSelef) self = weakSelef;
        self.type++;
        if (self.type > 4) {
            self.type = 0;
        }
    };
    NSInteger type = _type;
    [popupView tgtnShowPopupAnimationType:type];
}

@end
