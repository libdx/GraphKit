//
//  GKLink.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKLink <NSObject>

@property (strong, nonatomic) id<GKNode> inputNode;
@property (strong, nonatomic) id<GKNode> outputNode;

@property (nonatomic, getter=isHidden) BOOL hidden;

@end
