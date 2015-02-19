//
//  JSIntroductionView.m
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-11.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "JSIntroductionView.h"

@implementation JSIntroductionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //Avatar
        UIImageView *avatar = [[UIImageView alloc]initWithFrame:CGRectMake(94, -20, 132, 132)];
        [avatar setImage:[UIImage imageNamed:@"avatar.png"]];
        [self addSubview:avatar];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 130.0f, self.frame.size.width, 40.0f)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setText:@"Jonah Siegle"];
        [nameLabel setNumberOfLines:0];
        [nameLabel setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f]];
        [nameLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:nameLabel];
        
        
        UILabel *bioLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170.0f, self.frame.size.width, 80.0f)];
        [bioLabel setBackgroundColor:[UIColor clearColor]];
        [bioLabel setText:@"iOS developer and technology enthusiast."];
        [bioLabel setNumberOfLines:0];
        [bioLabel setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f]];
        [bioLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
        [bioLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:bioLabel];
        
        UILabel *scrollDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 290.0f, self.frame.size.width, 30.0f)];
        [scrollDownLabel setBackgroundColor:[UIColor clearColor]];
        [scrollDownLabel setText:@"Scroll to find out more."];
        [scrollDownLabel setNumberOfLines:0];
        [scrollDownLabel setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f]];
        [scrollDownLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:18.0f]];
        [scrollDownLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:scrollDownLabel];
        
    }
    return self;
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
