//
//  DifferInputView.h
//  AppGame
//
//  Created by zengchunjun on 2017/6/29.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ButtonClickBlock)(NSInteger index);
typedef void(^ReturnClickBlock)(NSString *result);

@interface DifferInputView : UIView

/*
 1.注意命名要求，@"leftImageName" 高亮则为：@"leftImageName_pre" 目的是为了少传几个参数。若传nil,则表示隐藏该按钮
 2.placeString 占位文字
 3.限制 字符数 为-1，则表示 没有限制
 4.textview的returnType 为send
 */
+ (instancetype)InputViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeString limitLength:(NSInteger)length leftImage:(NSString *)leftImage middleImage:(NSString *)midImage rightImage:(NSString *)rightImage buttonClickBlock:(ButtonClickBlock)callBack returnClick:(ReturnClickBlock)returnCallBack;

//获取 textview输入的内容，有时不一定在return时获取到
@property (nonatomic,copy)NSString *result;


//设置当前输入的限制字符数，默认 限制字符由上面的的类方法决定。
//注意：先调用 下面的becomeFirstResponderWithPlaceString：方法，是当前控件成为第一响应者，再调用这个方法来限制字符数
- (void)setCurrentLimitLength:(NSInteger)lenght;


//成为第一响应者，占位文字，若传 nil 占位文字 又上面的类方法决定
- (void)becomeFirstResponderWithPlaceString:(NSString *)string;

- (void)resignFirstResponderWithPlaceString:(NSString *)string;


@end
