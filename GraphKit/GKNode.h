//
//  GKNode.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKNode <NSObject>

@property (nonatomic, readonly) CGPoint center;
@property (strong, nonatomic, readonly) NSArray *links; // array of id<GKLink>

@end
