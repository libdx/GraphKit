//
//  UITextView+TextGeometry.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 12/13/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "UITextView+GKTextGeometry.h"

@implementation UITextView (GKTextGeometry)

+ (CGPoint)textOffset
{
    return CGPointMake(8, 8);
}

- (void)roundPosition
{
    switch (self.textAlignment)
    {
        case NSTextAlignmentCenter:
//            self.centerX = roundf(self.centerX);
            self.centerX = floorf(self.centerX);
            break;
        case NSTextAlignmentLeft:
        case NSTextAlignmentJustified:
            self.left = floorf(self.left);
            break;
        case NSTextAlignmentRight:
            self.right = ceilf(self.right);
            break;
        default:
            break;
    }
}

@end
