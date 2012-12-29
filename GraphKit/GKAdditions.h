//
//  GKAdditions.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 12/13/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (GKAdditions)
+ (CGPoint)textOffset;
- (void)roundPosition;
- (CGSize)sizeThatFitsTextContentsSize:(CGSize)contentsSize;
- (BOOL)isFitsTextContents;
@end

@interface NSString (GKAdditions)
+ (CGSize)singleCharacterSizeWithFont:(UIFont *)font;
- (NSString *)lastCharacter;
@end