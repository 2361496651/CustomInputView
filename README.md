# 使用UITextView封装聊天界面的输入框(占位文字、高度自适应、不用操心键盘的弹出与收回时更新Frame、字数限制以及按钮灵活配置)

#简书地址：http://www.jianshu.com/p/757ccec0b58f

1.注意命名要求，@"leftImageName" 高亮则为：@"leftImageName_pre" 目的是为了少传几个参数。若传nil,则表示隐藏该按钮\<br>
2.placeString 占位文字\<br>
3.限制 字符数 为-1，则表示 没有限制\<br>
4.textview的returnType 为send\<br>

        + (instancetype)InputViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeString limitLength:(NSInteger)length leftImage:(NSString *)leftImage middleImage:(NSString *)midImage rightImage:(NSString *)rightImage buttonClickBlock:(ButtonClickBlock)callBack returnClick:(ReturnClickBlock)returnCallBack;\<br>

//获取 textview输入的内容，有时不一定在return时获取到\<br>
@property (nonatomic,copy)NSString *result;\<br>

//设置当前输入的限制字符数，默认 限制字符由上面的的类方法决定。\<br>
//注意：先调用 下面的becomeFirstResponderWithPlaceString：方法，是当前控件成为第一响应者，再调用这个方法来限制字符数\<br>
- (void)setCurrentLimitLength:(NSInteger)lenght;\<br>

//成为第一响应者，占位文字，若传 nil 占位文字 又上面的类方法决定\<br>
- (void)becomeFirstResponderWithPlaceString:(NSString *)string;\<br>

- (void)resignFirstResponderWithPlaceString:(NSString *)string;\<br>


#使用：\<br>
CGFloat screenW = [UIScreen mainScreen].bounds.size.width;\<br>
CGFloat screenH = [UIScreen mainScreen].bounds.size.height;\<br>


        self.inputView = [DifferInputView InputViewWithFrame:CGRectMake(0, screenH - 44, screenW, 44) placeHolder:@"说点什么吧..." limitLength:100 leftImage:@"icon_like_down" middleImage:@"icon_like_down" rightImage:@"icon_like_down" buttonClickBlock:^(NSInteger index) {\<br>
        NSLog(@"%ld",index);\<br>
        // index 0:点击了左边的按钮，即使左边的图片传空，不显示左边的按钮，index为0也表示点击了左边的按钮，一次内推，1表示点击了中间的按钮，2表示点击了右边的按钮\<br>
        } returnClick:^(NSString *result) {\<br>
        NSLog(@"%@",result);\<br>
        self.textResult.text = result;\<br>
        }];


        [self.view addSubview:self.inputView];
