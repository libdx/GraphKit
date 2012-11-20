//
//  GKGraphView.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/18/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKGraph, GKNode, GKGraphViewDelegate;

@interface GKGraphView : UIView

@property (strong, nonatomic) UIView *backgroundView;

@property (weak, nonatomic) id<GKGraphViewDelegate> delegate;

- (void)addGraph:(id<GKGraph>)graph;
- (void)addNode:(id<GKNode>)node;

@end

@protocol GKGraphViewDelegate <NSObject>

@optional

// ignores |-graphView:sizeForViewWithNode:| if |-graphView:needsSizeToFitViewWithNode:| is implemented
// by default provides size 40x40
- (void)graphView:(GKGraphView *)graphView needsSizeToFitViewWithNode:(id<GKNode>)node;
- (CGSize)graphView:(GKGraphView *)graphView sizeForViewWithNode:(id<GKNode>)node;

@end
