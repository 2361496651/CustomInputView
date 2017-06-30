//
//  ViewController.m
//  CustomInputView
//
//  Created by zengchunjun on 2017/6/29.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import "ViewController.h"

#import "DifferInputView.h"

@interface ViewController ()

@property (nonatomic,strong)DifferInputView *inputView;
@property (weak, nonatomic) IBOutlet UILabel *textResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor purpleColor];
    [self setupUI];
    
}

- (void)setupUI
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    
    self.inputView = [DifferInputView InputViewWithFrame:CGRectMake(0, screenH - 44, screenW, 44) placeHolder:@"说点什么吧..." limitLength:100 leftImage:@"icon_like_down" middleImage:@"icon_like_down" rightImage:@"icon_like_down" buttonClickBlock:^(NSInteger index) {
        NSLog(@"%ld",index);
        // index 0:点击了左边的按钮，即使左边的图片传空，不显示左边的按钮，index为0也表示点击了左边的按钮，一次内推，1表示点击了中间的按钮，2表示点击了右边的按钮
    } returnClick:^(NSString *result) {
        NSLog(@"%@",result);
        self.textResult.text = result;
    }];
    

    [self.view addSubview:self.inputView];
    
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NSLog(@"%@==",self.inputView.result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
