//
//  GKNodeView.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKNodeView : UIView
{
@protected
    UITextView *_textView;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *backgroundView;

// Owerriden
- (BOOL)canBecomeFirstResponder;    // default is YES
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;


@end
