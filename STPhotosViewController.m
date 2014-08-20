//
//  STPhotosViewController.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPhotosViewController.h"
#import "STPhotoCell.h"

@interface STPhotosViewController ()

@end

@implementation STPhotosViewController

- (instancetype)init{
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

  // set layout item attributes
  layout.itemSize = CGSizeMake(106.0, 106.0);
  layout.minimumInteritemSpacing = 1.0;
  layout.minimumLineSpacing = 1.0;
  
  return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad{
  [super viewDidLoad];
  self.title = @"Photo Bombers";
  
  // register cell class so it can be reused later
  [self.collectionView registerClass:[STPhotoCell class] forCellWithReuseIdentifier:@"photo"];

  self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
  cell.backgroundColor = [UIColor lightGrayColor];
  
  return cell;
}

@end
