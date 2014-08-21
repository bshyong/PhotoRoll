//
//  STDismissDetailTransition.m
//  Photo Bombers
//
//  Created by Benjamin Shyong on 8/21/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STDismissDetailTransition.h"

@implementation STDismissDetailTransition

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
  UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  
  [UIView animateWithDuration:0.3 animations:^{
    detail.view.alpha = 0.0;
  } completion:^(BOOL finished) {
    [detail.view removeFromSuperview];
    [transitionContext completeTransition:YES];
  }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  return 0.3;
}

@end
