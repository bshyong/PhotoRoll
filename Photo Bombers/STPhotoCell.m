//
//  STPhotoCell.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPhotoCell.h"
#import <SAMCache/SAMCache.h>

@implementation STPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.imageView = [[UIImageView alloc] init];
      
      // add double-tap recognizer
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
      tap.numberOfTapsRequired = 2;
      [self addGestureRecognizer:tap];
      
      [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setPhoto:(NSDictionary *)photo{
  _photo = photo;
  
  NSURL *url = [[NSURL alloc] initWithString:_photo[@"images"][@"thumbnail"][@"url"]];
  [self downloadPhotoWithURL:url];
}

- (void)layoutSubviews{
  [super layoutSubviews];
  
  self.imageView.frame = self.contentView.bounds;
}

- (void)downloadPhotoWithURL:(NSURL *)url{

  NSString *key = [[NSString alloc] initWithFormat:@"%@-thumbnail", self.photo[@"id"]];
  UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
  
  if (photo){
    self.imageView.image = photo;
    return;
  }
  
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
    UIImage *image = [[UIImage alloc] initWithData:data];
    [[SAMCache sharedCache] setImage:image forKey:key];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = image;
    });
  }];
  [task resume];
}

- (void)showLikeCompletion{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
  [alert show];
  
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_MSEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
  });
}

-(void)like{
  NSURLSession *session = [NSURLSession sharedSession];
  NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
  NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"POST";
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self showLikeCompletion];
    });
  }];
  [task resume];
}

@end
