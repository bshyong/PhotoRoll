//
//  STPresentDetailTransition.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/21/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STPresentDetailTransition.h"

@implementation STPresentDetailTransition

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
  UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitionContext containerView];
  
  detail.view.alpha = 0.0;
  
  CGRect frame = containerView.bounds;
  frame.origin.y += 20.0;
  frame.size.height -= 20.0;
  detail.view.frame = frame;
  [containerView addSubview:detail.view];
  
  [UIView animateWithDuration:0.3 animations:^{
    detail.view.alpha = 1.0;
  } completion:^(BOOL finished) {
    [transitionContext completeTransition:YES];
  }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  return 0.3;
}

@end
