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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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

    UIImage *image = [[UIImage imageNamed:@"red-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 7, 9, 7)];
    _backgroundView = [[UIImageView alloc] initWithImage:image];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundView];

    _selectedBackgroundView = [[UIView alloc] init];
    _selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    self.selected = NO;
    [self addSubview:_selectedBackgroundView];

    _highlightedBackgroundView = [[UIView alloc] init];
    _highlightedBackgroundView.backgroundColor = [UIColor purpleColor];
    self.highlighted = NO;
    [self addSubview:_highlightedBackgroundView];

    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];

    _imageView = [[UIImageView alloc] init];
    [_contentView addSubview:_imageView];

    _textView = self.newTextView;
    _textView.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_textView];
}

- (NSArray *)backgroundViewKeys
{
    return @[@"_backgroundView", @"_selectedBackgroundView", @"_highlightedBackgroundView"];
}

static const UIEdgeInsets GKTextViewInset = {.top = 4.0f, .left = 4.0f, .bottom = 4.0f, .right = 4.0f};

- (void)layoutSubviews
{
    [super layoutSubviews];

    _contentView.frame = self.bounds;
    _imageView.frame = _contentView.bounds;
    _textView.frame = _contentView.bounds;
    _textView.width -= GKTextViewInset.left + GKTextViewInset.right;
    _textView.height -= GKTextViewInset.top + GKTextViewInset.bottom;
    _textView.left = GKTextViewInset.left;
    _textView.top = GKTextViewInset.top;
    for (NSString *key in self.backgroundViewKeys) {
        UIView *view = [self valueForKey:key];
        view.frame = self.bounds;
    }
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
        [_contentView insertSubview:imageView belowSubview:_textView];
    }
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self insertSubview:_backgroundView atIndex:0];
    }
}

- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView
{
    if (_selectedBackgroundView != selectedBackgroundView) {
        [_selectedBackgroundView removeFromSuperview];
        _selectedBackgroundView = selectedBackgroundView;
        [self insertSubview:_selectedBackgroundView aboveSubview:_backgroundView];
    }
}

- (void)setHighlightedBackgroundView:(UIView *)highlightedBackgroundView
{
    if (_highlightedBackgroundView != highlightedBackgroundView) {
        [_highlightedBackgroundView removeFromSuperview];
        _highlightedBackgroundView = highlightedBackgroundView;
        [self insertSubview:_highlightedBackgroundView aboveSubview:_selectedBackgroundView];
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    _selectedBackgroundView.hidden = !_selected;
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    _highlightedBackgroundView.hidden = !_highlighted;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    // TODO: return size to respect view's content
    return CGSizeMake(60, 60);

//    CGSize result;
//    CGSize imageSize = [_imageView sizeThatFits:size];
//    CGSize textSize = [_textView sizeThatFits:size];
//    result.width = MAX(imageSize.width, textSize.width);
//    result.height = MAX(imageSize.height, textSize.width);
//    return result;
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
