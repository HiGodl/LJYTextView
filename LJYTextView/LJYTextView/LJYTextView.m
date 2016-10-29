//
//  LJYTextView.m
//  LJYTextView
//
//  Created by jyLu on 16/3/29.
//  Copyright © 2016年 jyLu. All rights reserved.
//

#import "LJYTextView.h"

@interface LJYTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, assign) NSInteger totalNumCount;

@end

@implementation LJYTextView

-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.maxLength = 0;
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.maxLength = 0;
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.x = 5;
    frame.origin.y = 8;
    self.placeholderLabel.frame = frame;
    CGSize maxSize = CGSizeMake(self.frame.size.width - 2 * self.placeholderLabel.frame.origin.x, CGFLOAT_MAX);
    NSString *text = self.placeholderLabel.text;
    if (!text) {
        return;
    }
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholderLabel.font} context:nil].size;
    frame.size = size;
    self.placeholderLabel.frame = frame;
}

-(void)setupUI{
    [self addSubview:self.placeholderLabel];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeholderLabel.text = placeHolder;
}

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = [UIFont systemFontOfSize:12];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.numberOfLines = 0;
    }
    return _placeholderLabel;
}

-(void)setText:(NSString *)text{
    [super setText:text];
    NSNotification *noti = [[NSNotification alloc] initWithName:UITextViewTextDidChangeNotification object:self userInfo:nil];
    [self textDidChange:noti];
}


-(void)textDidChange:(NSNotification *)obj{
    self.placeholderLabel.hidden = [self hasText];
    if (self.maxLength == 0) {
        return;
    }
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
            }
        }
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if(toBeString.length > self.maxLength) {
            textField.text= [toBeString substringToIndex:self.maxLength];
        }
    }
}


@end
