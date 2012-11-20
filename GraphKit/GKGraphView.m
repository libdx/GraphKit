//
//  GKGraphView.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/18/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "GKGraphView.h"
#import "GKNodeView.h"
#import "GKGraph.h"
#import "GKNode.h"

@implementation GKGraphView
{
@protected
    UIView *_backgroundView;
    UIScrollView *_contentView;
    UIView *_contentBackgroundView;
    UIView *_graphicView;
    UIView *_nodesView;
    UIView *_decorationsView;
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
    return @[@"_contentBackgroundView", @"_graphicView", @"_nodesView", @"_decorationsView"];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addSubview:_backgroundView];
    }
}

static const CGSize GKNodeViewSize = {.width = 40.0f, .height = 40.0f};

- (void)layoutSubviews
{
    [super layoutSubviews];

    _backgroundView.frame = self.bounds;
    _contentView.frame = self.bounds;
    for (NSString *key in self.contentSubviewKeys) {
        UIView *view = [self valueForKey:key];
        view.frame = _contentView.bounds;
        [_contentView addSubview:view];
    }
    BOOL delegateNeedsSizeToFit = [_delegate respondsToSelector:@selector(graphView:needsSizeToFitViewWithNode:)];
    BOOL delegateSizeForView = [_delegate respondsToSelector:@selector(graphView:sizeForViewWithNode:)];
    for (GKNodeView *view in _nodesView.subviews) {
        view.center = view.node.center;
        if (delegateNeedsSizeToFit)
            [view sizeToFit];
        else if (delegateSizeForView)
            view.size = [_delegate graphView:self sizeForViewWithNode:view.node];
        else
            view.size = GKNodeViewSize;
    }
}

- (void)addGraph:(id<GKGraph>)graph
{
    for (id<GKNode> node in graph.nodes)
        [self addNode:node];
}

- (void)addNode:(id<GKNode>)node
{
    GKNodeView *view = [[GKNodeView alloc] initWithNode:node];
    [_nodesView addSubview:view];
}

@end
