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

- (void)layoutSubviews{
  [super layoutSubviews];
  
  self.imageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
