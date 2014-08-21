//
//  STDetailViewController.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/20/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STDetailViewController.h"
#import "STPhotoController.h"

@interface STDetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;
@end

@implementation STDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.85];
  
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.0, 320.0f, 320.0f)];
    [self.view addSubview:self.imageView];
  
  [STPhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
    self.imageView.image = image;
  }];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
  [self.view addGestureRecognizer:tap];
  
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:self.view.center];
  [self.animator addBehavior:snap];
}

-(void)close{
  [self.animator removeAllBehaviors];
  UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
  [self.animator addBehavior:snap];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
