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

@protocol GKGraph <NSObject>
// ?
@end

@protocol GKNode <NSObject>

@property (nonatomic) CGPoint center;

@property (strong, nonatomic) NSArray *links; // of id<GKLink>

@end

@protocol GKLink <NSObject>

@property (strong, nonatomic) id<GKNode> inputNode;
@property (strong, nonatomic) id<GKNode> outputNode;

@property (nonatomic, getter=isHidden) BOOL hidden;

@end
