//
//  GKNodeView.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKNode;

@interface GKNodeView : UIView
{
@protected
    UITextView *_textView;
}

@property (strong, nonatomic, readonly) UIView *contentView;
@property (strong, nonatomic, readonly) UITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) id<GKNode> node;

- (id)initWithNode:(id<GKNode>)node;

- (BOOL)canBecomeFirstResponder;    // default is YES

@end
