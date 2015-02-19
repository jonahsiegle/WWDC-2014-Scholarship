//
//  JSTransitionImageView.m
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-11.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "JSTransitionImageView.h"

@implementation JSTransitionImageView{
    
    //Private variables
    
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageViewOne = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:imageViewOne];
        
        imageViewTwo = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:imageViewTwo];
        
        
    }
    return self;
}

- (void)transitionBetweenImages:(UIImage *)imageOne imageTwo:(UIImage *)imageTwo ratio:(CGFloat)imageRatio{
    
    [self setImageOne:imageOne];
    [self setImageTwo:imageTwo];
    
    [self setImageRatio:imageRatio];

}

- (void)setImageRatio:(CGFloat)imageRatio{
    
    [imageViewOne setAlpha:1.0f-imageRatio];
    [imageViewTwo setAlpha:imageRatio];
}

- (void) setImageOne:(UIImage *)imageOne{
    [imageViewOne setImage:imageOne];
}

- (void)setImageTwo:(UIImage *)imageTwo{
    [imageViewTwo setImage:imageTwo];
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
