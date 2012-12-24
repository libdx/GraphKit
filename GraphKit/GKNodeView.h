//
//  GKNodeView.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKNode;

@interface GKNodeView : UIView <UITextViewDelegate>
{
@protected
    UITextView *_textView;
}

@property (strong, nonatomic, readonly) UIView *contentView;
@property (strong, nonatomic, readonly) UITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *selectedBackgroundView;
@property (strong, nonatomic) UIView *highlightedBackgroundView;

@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@property (strong, nonatomic, readonly) UIResponder *inputResponder;

@property (nonatomic) CGSize constrainedSize;

@property (strong, nonatomic) id<GKNode> node;

- (id)initWithNode:(id<GKNode>)node;

@end

@interface GKNodeView (SubclassesHooks)
// Use for manipulating with background view shape. Commonly shape layer is provided. Is called on |-layoutSubviews|
- (CALayer *)backgroundMaskLayer;
@end
