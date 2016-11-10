//
//  UIView+Uitls.h
//  SCAutoMove
//
//  Created by show class on 15/11/25.
//  Copyright © 2015年 show class. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Uitls)

@property (nonatomic) IBInspectable UIColor *borderColorOnInspec;
@property (nonatomic) IBInspectable CGFloat borderWidthOnInspec;
@property (nonatomic) IBInspectable CGFloat cornerRadiusOnInspec;
@property (nonatomic) IBInspectable BOOL maskToBoundsOnInspec;

- (void)setBorderWidth:(CGFloat)with;

- (CGFloat)borderWidth;

- (void)setBorderColor:(UIColor *)color;

- (UIColor *)borderColor;

- (CGFloat)x;

- (CGFloat)y;

- (CGFloat)width;

- (CGFloat)height;

- (CGPoint)origin;

- (CGSize)size;

- (void)setX:(CGFloat)x;

- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setOrigin:(CGPoint)origin;

- (void)setSize:(CGSize)size;

- (CGFloat)left;

- (CGFloat)right;

- (CGFloat)top;

- (CGFloat)bottom;
@end

@interface UIView(FindFirstResponder)
- (UIView *)findFirstResponder;
@end