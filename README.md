# Objective-C-Project

#自定义输入框

1.注意命名要求，@"leftImageName" 高亮则为：@"leftImageName_pre" 目的是为了少传几个参数。若传nil,则表示隐藏该按钮
2.placeString 占位文字
3.限制 字符数 为-1，则表示 没有限制
4.textview的returnType 为send

+ (instancetype)InputViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeString limitLength:(NSInteger)length leftImage:(NSString *)leftImage middleImage:(NSString *)midImage rightImage:(NSString *)rightImage buttonClickBlock:(ButtonClickBlock)callBack returnClick:(ReturnClickBlock)returnCallBack;

//获取 textview输入的内容，有时不一定在return时获取到
@property (nonatomic,copy)NSString *result;

//设置当前输入的限制字符数，默认 限制字符由上面的的类方法决定。
//注意：先调用 下面的becomeFirstResponderWithPlaceString：方法，是当前控件成为第一响应者，再调用这个方法来限制字符数
- (void)setCurrentLimitLength:(NSInteger)lenght;

//成为第一响应者，占位文字，若传 nil 占位文字 又上面的类方法决定
- (void)becomeFirstResponderWithPlaceString:(NSString *)string;

- (void)resignFirstResponderWithPlaceString:(NSString *)string;


#使用：
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
