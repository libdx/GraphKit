//
//  GKGraphView.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/18/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "GKGraphView.h"

@implementation GKGraphView
{
@protected
    UIView *_backgroundView;
    UIScrollView *_contentView;
    UIView *_contentBackgroundView;
    UIView *_contentGraphicView;
    UIView *_contentDecorationsView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initialSetup];
    return self;
}

- (void)initialSetup
{
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundView];
    _contentView = [[UIScrollView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    for (NSString *key in self.contentSubviewKeys) {
        [self setValue:[[UIView alloc] init] forKey:key];
        UIView *view = [self valueForKey:key];
        view.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:view];
    }
}

- (NSArray *)contentSubviewKeys
{
    return @[@"_contentBackgroundView", @"_contentGraphicView", @"_contentDecorationsView"];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        _backgroundView = backgroundView;
        [self addSubview:_backgroundView];
    }
}

- (void)addGraph:(id<GKGraph>)graph
{
}

- (void)addNode:(id<GKNode>)node
{
}

@end
