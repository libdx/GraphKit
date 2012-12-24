//
//  GKNodeView.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "GKNodeView.h"

#import <QuartzCore/QuartzCore.h> //tmp
#import "UITextView+GKTextGeometry.h"

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
    UIImage *image = [[UIImage imageNamed:@"gknodeview-default-bg.png"]
                      resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7) resizingMode:UIImageResizingModeStretch];
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
    _textView.delegate = self;
//    _textView.textAlignment = NSTextAlignmentCenter; //?
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
//    _textView.backgroundColor = [UIColor yellowColor]; //tmp
//    _textView.alpha = 0.3; //tmp
    [_contentView addSubview:_textView];

    _constrainedSize = CGSizeMake(230, 150);
}

- (NSArray *)backgroundViewKeys
{
    return @[@"_backgroundView", @"_selectedBackgroundView", @"_highlightedBackgroundView"];
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

#pragma mark - Geometry

- (void)layoutSubviews
{
    [super layoutSubviews];

    _contentView.frame = self.bounds;
    _imageView.frame = _contentView.bounds;
    _textView.size = [self sizeForTextView:_textView];
    _textView.center = CGPointMake(round(0.5*_contentView.width), round(0.5*_contentView.height));
//    _textView.left = floor(_textView.left); // this will make x coordinate more constant and smooth fractions
    [_textView roundPosition];
    NSLog(@"%f", _textView.left);
    for (NSString *key in self.backgroundViewKeys) {
        UIView *view = [self valueForKey:key];
        view.frame = self.bounds;
    }
    //    _backgroundView.layer.mask = [self backgroundMaskLayer]; //experiment
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize res = CGSizeMake(150, 80); // must depend on font
    CGFloat width = [self textContentsWidthForObject:_textView];
    CGFloat height = [self textContentsHeightForObject:_textView forWidth:width];
    CGSize newSize = [self sizeThatFitsTextContentsSize:CGSizeMake(width, height)];
    // ensure that view will become not smaller than minimal size
    res.width = newSize.width > res.width ? newSize.width : res.width;
    res.height = newSize.height > res.height ? newSize.height : res.height;
    // ensure that view will become not bigger than |_constrainedSize|
    res.width = res.width > _constrainedSize.width ? _constrainedSize.width : res.width;
    res.height = res.height > _constrainedSize.height ? _constrainedSize.height : res.height;

    // check whenever we need to change size of |_textView|
    if (NO == CGSizeEqualToSize(_textView.size, [self sizeForTextView:_textView]))
        [self setNeedsLayout];

    return res;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self sizeToFit];
}

static const UIEdgeInsets GKTextContentsInsets = {.top = 10.0f, .left = 10.0f, .bottom = 10.0f, .right = 10.0f};
- (CGSize)textContentsSizeThatRespectsSize:(CGSize)size
{
    size.width -= GKTextContentsInsets.left + GKTextContentsInsets.right;
    size.height -= GKTextContentsInsets.top + GKTextContentsInsets.bottom;
    return size;
}
- (CGSize)sizeThatFitsTextContentsSize:(CGSize)contentsSize
{
    CGSize res = [self textContentsSizeThatRespectsSize:contentsSize];
    res.width += 2 * (contentsSize.width - res.width);
    res.height += 2 * (contentsSize.height - res.height);
    return res;
}

//
// Results are limited to contrained size of text contents
//
// object must has property |NSString *text| and |UIFont *font| acceptable through |-valueForKey|.
// Usualy UITextView, UITextField or UILabel are used but NSDictionary can be used as well.
//
- (CGFloat)textContentsWidthForObject:(id)object
{
    NSString *text = [object valueForKey:@"text"];
    UIFont *font = [object valueForKey:@"font"];
    NSArray *components = [text componentsSeparatedByString:@"\n"];
    text = components.count>0 ? components[0] : text;
    CGFloat res = [text sizeWithFont:font
                            forWidth:[self textContentsSizeThatRespectsSize:_constrainedSize].width
                       lineBreakMode:NSLineBreakByClipping].width;
    return res;
}
- (CGFloat)textContentsHeightForObject:(id)object forWidth:(CGFloat)width
{
    NSString *text = [object valueForKey:@"text"];
    UIFont *font = [object valueForKey:@"font"];
    CGFloat res = [text sizeWithFont:font
                   constrainedToSize:CGSizeMake(width, MAXFLOAT)
                       lineBreakMode:NSLineBreakByWordWrapping].height;
    // ensure that height is not bigger than constrained contents' height
    CGSize constrainedSize = [self textContentsSizeThatRespectsSize:_constrainedSize];
    res = res < constrainedSize.height ? res : constrainedSize.height;
    return res;
}

- (CGSize)sizeForTextView:(UITextView *)textView
{
    CGSize res;
    res.width = [self textContentsWidthForObject:textView];
    res.height = [self textContentsHeightForObject:textView forWidth:res.width];
    res.width += 2*UITextView.textOffset.x;
    res.height += 2*UITextView.textOffset.y;
    CGSize minSize = CGSizeMake(90, 50); // must depend on font
    // ensure that result is bigger than minimal allowed size
    res.width = res.width > minSize.width ? res.width : minSize.width;
    res.height = res.height > minSize.height ? res.height : minSize.height;
    return res;
}

#pragma mark - UIResponder

- (UIResponder *)inputResponder
{
    return _textView;
}

#pragma mark - Experiments

- (CALayer *)backgroundMaskLayer
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, _backgroundView.bounds);
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = CGPathCreateCopy(path);

    // use this to create outline
    //    mask.path = CGPathCreateCopyByStrokingPath(path, NULL, 5, kCGLineCapButt, kCGLineJoinMiter, 2);

    CGPathRelease(path);
    mask.lineWidth = 5;
    return mask;
}

@end
