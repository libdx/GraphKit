//
//  TestViewController.m
//  GraphKit
//
//  Created by Alexander Ignatenko on 11/21/12.
//  Copyright (c) 2012 Alexander Ignatenko. All rights reserved.
//

#import "TestViewController.h"
#import "GKGraphView.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet GKGraphView *graphView;

@end

@implementation TestViewController

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

@end
