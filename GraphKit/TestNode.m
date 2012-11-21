//
//  TestNode.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/21/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "TestNode.h"

@implementation TestNode

@synthesize center = _center;
@synthesize links = _links;

- (id)initWithCenter:(CGPoint)center
{
    self = [super init];
    if (self) {
        _center = center;
    }
    return self;
}

@end
