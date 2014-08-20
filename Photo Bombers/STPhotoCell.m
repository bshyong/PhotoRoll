//
//  STPhotoCell.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPhotoCell.h"

@implementation STPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.imageView = [[UIImageView alloc] init];
      self.imageView.image = [UIImage imageNamed:@"Treehouse"];
      
      [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setPhoto:(NSDictionary *)photo{
  _photo = photo;
  
  NSURL *url = [[NSURL alloc] initWithString:_photo[@"images"][@"standard_resolution"][@"url"]];
  [self downloadPhotoWithURL:url];
}

- (void)layoutSubviews{
  [super layoutSubviews];
  
  self.imageView.frame = self.contentView.bounds;
}

- (void)downloadPhotoWithURL:(NSURL *)url{
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
    UIImage *image = [[UIImage alloc] initWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = image;
    });
  }];
  [task resume];
}

@end
