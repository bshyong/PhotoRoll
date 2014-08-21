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
@end

@implementation STDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
  
  [STPhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
    self.imageView.image = image;
  }];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
  [self.view addGestureRecognizer:tap];
}

-(void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  
  // center image in view
  CGSize size = self.view.bounds.size;
  CGSize imageSize = CGSizeMake(size.width, size.height);
  self.imageView.frame = CGRectMake(0.0, (size.height - imageSize.height) / 2.0, imageSize.width, imageSize.height);
}

-(void)close{
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
