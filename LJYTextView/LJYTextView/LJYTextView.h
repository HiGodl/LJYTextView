//
//  LJYTextView.h
//  LJYTextView
//
//  Created by jyLu on 16/3/29.
//  Copyright © 2016年 jyLu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface LJYTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString *placeHolder;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) NSInteger maxLength;

@end
