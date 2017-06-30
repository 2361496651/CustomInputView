//
//  DifferInputView.m
//  AppGame
//
//  Created by zengchunjun on 2017/6/29.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import "DifferInputView.h"

@interface DifferInputView ()<UITextViewDelegate>

@property (nonatomic,assign)CGRect originFrame;//原始frame

//三个按钮的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midBtnWithdConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnWidthConst;


@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

//限制的字符数
@property (nonatomic,assign)NSInteger limitLength;

//最初的限制字符数
@property (nonatomic,assign)NSInteger originLimitLenght;

//placeString
@property (nonatomic,copy)NSString *placeString;
//按钮回调
@property (nonatomic,copy)ButtonClickBlock callBack;
//点击return
@property (nonatomic,copy)ReturnClickBlock returnClickCallBack;
@end

@implementation DifferInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"DifferInputView" owner:nil options:nil].firstObject;
        
        self.originFrame = frame;
        [self initSetting];
    }
    self.frame = frame;
    return self;
}

- (void)initSetting
{
//    self.textView.textContainerInset = UIEdgeInsetsMake(4, 2, 4, 2);
    
    //监听键盘frame改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = self.frame;
    frame.origin.y = endFrame.origin.y - frame.size.height;
    self.originFrame = frame;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.frame = frame;
        
        
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    
}

+ (instancetype)InputViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeString limitLength:(NSInteger)length leftImage:(NSString *)leftImage middleImage:(NSString *)midImage rightImage:(NSString *)rightImage buttonClickBlock:(ButtonClickBlock)callBack returnClick:(ReturnClickBlock)returnCallBack
{
    DifferInputView *inputView = [[DifferInputView alloc] initWithFrame:frame];
    inputView.limitLength = length;
    inputView.originLimitLenght = length;
    
    inputView.callBack = callBack;
    inputView.returnClickCallBack = returnCallBack;
    
    inputView.placeString = placeString;
    inputView.placeHolderLabel.text = placeString;
    
    [inputView.leftBtn setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
    [inputView.leftBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",leftImage]] forState:UIControlStateHighlighted];
    
    [inputView.middleBtn setImage:[UIImage imageNamed:midImage] forState:UIControlStateNormal];
    [inputView.middleBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",midImage]] forState:UIControlStateHighlighted];
    
    [inputView.rightBtn setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
    [inputView.rightBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",rightImage]] forState:UIControlStateHighlighted];
    
    //隐藏 按钮
    if (leftImage == nil) {
        inputView.leftBtnWidthConst.constant = 0;
    }
    
    if (midImage == nil) {
        inputView.midBtnWithdConst.constant = 0;
    }
    
    if (rightImage == nil) {
        inputView.rightBtnWidthConst.constant = 0;
    }
    
    return inputView;
    
}

- (IBAction)leftBtnClick:(UIButton *)sender {
    self.callBack(0);
}

- (IBAction)middleBtnClick:(UIButton *)sender {
    self.callBack(1);
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    self.callBack(2);
}


#pragma mark:UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
//    NSLog(@"%lf",self.textView.contentSize.height);
    
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        self.placeHolderLabel.text = self.placeString;
    }else{
        self.placeHolderLabel.text = nil;
    }
    
    
    NSInteger length = self.limitLength;//限制的字数
    
    if (length != -1) {
        
        NSString *toBeString = textView.text;
        //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        NSString *lang = textView.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textView markedTextRange];       //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position || !selectedRange)
            {
                if (toBeString.length > length)
                {
                    NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:length];
                    if (rangeIndex.length == 1)
                    {
                        textView.text = [toBeString substringToIndex:length];
                    }
                    else
                    {
                        NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, length)];
                        textView.text = [toBeString substringWithRange:rangeRange];
                    }
                }
            }
            
        }else{
            if (toBeString.length > length) {
                textView.text = [toBeString substringToIndex:length];
            }
        }
    }
    
    //赋值，
    self.result = textView.text;
    
    
    //更新frame
    CGRect frame = self.originFrame;
    CGFloat height = self.textView.contentSize.height + 4 + 4 + 3;//上下间距都为4
    frame.origin.y -=  height - frame.size.height;
    frame.size.height = height;
    self.frame = frame;
    

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//判断输入的字是否是回车，即按下return
        self.returnClickCallBack(textView.text);
        self.textView.text = nil;
        self.result = nil;
        [self textViewDidChange:self.textView];
        return NO;
    }
    
    return YES;
}

- (void)setCurrentLimitLength:(NSInteger)lenght
{
    self.limitLength = lenght;
    self.textView.text = nil;
    
    [self textViewDidChange:self.textView];
}

- (void)becomeFirstResponderWithPlaceString:(NSString *)string
{
    [self.textView becomeFirstResponder];
    
    if (string) {
        self.placeHolderLabel.text = string;
        self.placeString = string;
    }
    
    self.limitLength = self.originLimitLenght;
    [self textViewDidChange:self.textView];
}

- (void)resignFirstResponderWithPlaceString:(NSString *)string
{
    [self.textView resignFirstResponder];
    
    if (string) {
        self.placeHolderLabel.text = string;
        self.placeString = string;
    }
    
    self.limitLength = self.originLimitLenght;
    [self textViewDidChange:self.textView];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}



@end
