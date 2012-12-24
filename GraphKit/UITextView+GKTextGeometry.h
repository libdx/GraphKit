//
//  UITextView+TextGeometry.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 12/13/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (GKTextGeometry)

+ (CGPoint)textOffset;

- (void)roundPosition;

@end
