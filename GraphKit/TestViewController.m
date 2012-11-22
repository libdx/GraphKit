//
//  TestViewController.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/21/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "TestViewController.h"
#import "GKGraphView.h"
#import "GKNodeView.h"
#import "TestNode.h"

@interface TestViewController () <GKGraphViewDelegate>

@property (weak, nonatomic) IBOutlet GKGraphView *graphView;

@end

@implementation TestViewController
{
    NSMutableArray *_nodes;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _graphView.delegate = self;

    _nodes = [[NSMutableArray alloc] init];
    TestNode *node = [[TestNode alloc] initWithCenter:CGPointMake(350, 250)];
    node.text = @"First Node";
    [_nodes addObject:node];
    [_graphView addNode:node];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (GKNodeView *)graphView:(GKGraphView *)graphView viewForNode:(id<GKNode>)node
{
    GKNodeView *view = [[GKNodeView alloc] initWithNode:node];
    if (_nodes[0] == node)
        view.textView.text = [_nodes[0] text];
    return view;
}

- (BOOL)graphView:(GKGraphView *)graphView needsSizeToFitViewWithNode:(id<GKNode>)node
{
    return YES;
}

- (CGSize)graphView:(GKGraphView *)graphView sizeForViewWithNode:(id<GKNode>)node
{
    return CGSizeMake(100, 100);
}

@end
