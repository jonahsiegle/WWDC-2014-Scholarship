//
//  JSTransitionImageView.h
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-11.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSTransitionImageView : UIView

@property (nonatomic, assign) CGFloat imageRatio;

@property (nonatomic, strong) UIImage *imageOne;
@property (nonatomic, strong) UIImage *imageTwo;


- (void)transitionBetweenImages:(UIImage *)imageOne imageTwo:(UIImage *)imageTwo ratio:(CGFloat)imageRatio;

@end
