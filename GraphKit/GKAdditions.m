//
//  GKAdditions.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 12/13/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "GKAdditions.h"

@implementation UITextView (GKAdditions)

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

- (CGSize)sizeThatFitsTextContentsSize:(CGSize)contentsSize
{
    CGSize res = contentsSize;
    CGSize singleCharacterSize = [NSString singleCharacterSizeWithFont:self.font];
    CGSize minSize = CGSizeMake(4*singleCharacterSize.width,
                                singleCharacterSize.height);

    // ensure that result is bigger than minimal allowed size
    res.width = res.width > minSize.width ? res.width : minSize.width;
    res.height = res.height > minSize.height ? res.height : minSize.height;

    res.width += 2*UITextView.textOffset.x;
    res.height += 2*UITextView.textOffset.y;
    return res;
}

- (BOOL)isFitsTextContents
{
    return NO;
}

@end

@implementation NSString (GKAdditions)

+ (CGSize)singleCharacterSizeWithFont:(UIFont *)font
{
    return [@"a" sizeWithFont:font
            constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                lineBreakMode:NSLineBreakByWordWrapping];
}

- (NSString *)lastCharacter
{
    NSString *res;
    NSInteger lastIndex = self.length - 1;
    if (lastIndex >= 0)
        res = [self substringFromIndex:lastIndex];
    return res;
}

@end