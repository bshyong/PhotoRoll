//
//  STPhotosViewController.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPhotosViewController.h"
#import "STPhotoCell.h"
#import <SimpleAuth/SimpleAuth.h>

@interface STPhotosViewController ()

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;

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
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  self.accessToken = [userDefaults objectForKey:@"accessToken"];
  
  if (self.accessToken == nil) {
    [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
      // get access token from response
      NSString *accessToken = responseObject[@"credentials"][@"token"];
      [userDefaults setObject:accessToken forKey:@"accessToken"];
      [userDefaults synchronize];
    }];
  } else {
    [self refresh];
  }
}

-(void)refresh{
  NSURLSession *session = [NSURLSession sharedSession];
  NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/snow/media/recent?access_token=%@", self.accessToken];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSLog(@"photos: %@", urlString);
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.photos = [responseDictionary valueForKeyPath:@"data"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.collectionView reloadData];
    });
    
  }];
  [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  STPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
  cell.backgroundColor = [UIColor lightGrayColor];
  cell.photo = self.photos[indexPath.row];
  
  return cell;
}

@end
