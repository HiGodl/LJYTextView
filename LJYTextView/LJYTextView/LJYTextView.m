//
//  LJYTextView.m
//  LJYTextView
//
//  Created by jyLu on 16/3/29.
//  Copyright © 2016年 jyLu. All rights reserved.
//

#import "LJYTextView.h"

@interface LJYTextView ()

@property (nonatomic, strong)UILabel *placeholderLabel;

@end

@implementation LJYTextView

-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
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
    [self textDidChange];
}

-(void)textDidChange{
    self.placeholderLabel.hidden = [self hasText];
}

@end
