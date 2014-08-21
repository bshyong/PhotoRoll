//
//  STPhotoController.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/20/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPhotoController.h"
#import <SAMCache/SAMCache.h>

@implementation STPhotoController

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion{
  
  if (photo == nil || size == nil || completion == nil){
    return;
  }
  
  NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
  UIImage *image = [[SAMCache sharedCache] imageForKey:key];
  
  if (image){
    completion(image);
    return;
  }
  
  NSURLSession *session = [NSURLSession sharedSession];
  NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
    UIImage *image = [[UIImage alloc] initWithData:data];
    [[SAMCache sharedCache] setImage:image forKey:key];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(image);
    });
  }];
  [task resume];
}

@end
