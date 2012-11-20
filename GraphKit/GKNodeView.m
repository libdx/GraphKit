//
//  GKNodeView.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "GKNodeView.h"

@implementation GKNodeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _node = nil;
        [self initialSetup];
    }
    return self;
}

- (id)initWithNode:(id<GKNode>)node
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _node = node;
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup
{
    // TODO: setup default appearance
    _contentView = [[UIView alloc] init];
    
    _textView = self.newTextView;
    _textView.backgroundColor = [UIColor clearColor];
    
    // provide default image for |_imageView|
    _imageView = [[UIImageView alloc] init];
    [_contentView addSubview:_imageView];
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blueColor];
    [_contentView addSubview:_backgroundView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
    _imageView.frame = _contentView.bounds;
    _backgroundView.frame = _contentView.bounds;
}

- (UITextView *)newTextView
{
    return [[UITextView alloc] init];
}

- (void)setImageView:(UIImageView *)imageView
{
    if (_imageView != imageView) {
        [_imageView removeFromSuperview];
        _imageView = imageView;
        [self addSubview:imageView];
    }
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addSubview:_backgroundView];
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize result;
    CGSize imageSize = [_imageView sizeThatFits:size];
    CGSize textSize = [_textView sizeThatFits:size];
    result.width = MAX(imageSize.width, textSize.width);
    result.height = MAX(imageSize.height, textSize.width);
    return result;
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return [_textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textView resignFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [_textView isFirstResponder];
}

@end
