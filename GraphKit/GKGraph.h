//
//  GKGraph.h
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/20/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKGraph <NSObject>

@property (strong, nonatomic) NSArray *nodes; // array of id<GKNode>

@end
