//
//  JSAppsDisplayView.m
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-12.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "JSAppsDisplayView.h"

@implementation JSAppsDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
    
        //App Icons
        
        UIButton *chippCatch = [UIButton buttonWithType:UIButtonTypeCustom];
        [chippCatch setFrame:CGRectMake(10, 45, 69, 86)];
        [chippCatch setImage:[UIImage imageNamed:@"cc.png"] forState:UIControlStateNormal];
        [chippCatch setTag:0];
        [chippCatch addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chippCatch];
        
        UIButton *htmlMailer = [UIButton buttonWithType:UIButtonTypeCustom];
        [htmlMailer setFrame:CGRectMake(125, 45, 69, 86)];
        [htmlMailer setImage:[UIImage imageNamed:@"html.png"] forState:UIControlStateNormal];
        [htmlMailer setTag:1];
        [htmlMailer addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:htmlMailer];
        
        UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
        [search setFrame:CGRectMake(240, 45, 69, 86)];
        [search setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        [search setTag:2];
        [search addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:search];
        
        
        UIButton *keychain = [UIButton buttonWithType:UIButtonTypeCustom];
        [keychain setFrame:CGRectMake(10, 220, 69, 86)];
        [keychain setImage:[UIImage imageNamed:@"keychain.png"] forState:UIControlStateNormal];
        [keychain setTag:3];
        [keychain addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keychain];
        
        UIButton *whirl = [UIButton buttonWithType:UIButtonTypeCustom];
        [whirl setFrame:CGRectMake(125, 220, 69, 86)];
        [whirl setImage:[UIImage imageNamed:@"whirl.png"] forState:UIControlStateNormal];
        [whirl setTag:4];
        [whirl addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:whirl];
        
        UIButton *deploy = [UIButton buttonWithType:UIButtonTypeCustom];
        [deploy setFrame:CGRectMake(240, 220, 69, 86)];
        [deploy setImage:[UIImage imageNamed:@"deploy.png"] forState:UIControlStateNormal];
        [deploy setTag:5];
        [deploy addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deploy];
        
        
        
        UIButton *flappyChicken = [UIButton buttonWithType:UIButtonTypeCustom];
        [flappyChicken setFrame:CGRectMake(130, 470, 60, 60)];
        [flappyChicken setImage:[UIImage imageNamed:@"flappychicken.png"] forState:UIControlStateNormal];
        [flappyChicken setTag:6];
        [flappyChicken addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:flappyChicken];
        
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 300, 20)];
        [topLabel setText:@"2009-2010"];
        [topLabel setTextColor:[UIColor whiteColor]];
        [topLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:16.0f]];
        [self addSubview:topLabel];
        
        
        UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 180, 300, 20)];
        [bottomLabel setText:@"2011-2013"];
        [bottomLabel setTextColor:[UIColor whiteColor]];
        [bottomLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:16.0f]];
        [self addSubview:bottomLabel];
        
        
//        UILabel *tapIcon = [[UILabel alloc]initWithFrame:CGRectMake(0, 330, 320, 20)];
//        [tapIcon setText:@"(Tap on an icon to view information.)"];
//        [tapIcon setTextColor:[UIColor whiteColor]];
//        [tapIcon setTextAlignment:NSTextAlignmentCenter];
//        [tapIcon setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0f]];
//        [self addSubview:tapIcon];
        
        
        UILabel *flappyChickenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 535, 320, 20)];
        [flappyChickenLabel setText:@"Flappy Chicken"];
        [flappyChickenLabel setTextColor:[UIColor whiteColor]];
        [flappyChickenLabel setTextAlignment:NSTextAlignmentCenter];
        [flappyChickenLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:12.0f]];
        [self addSubview:flappyChickenLabel];
        
        
        
        
        
        
        UILabel *weekendProject = [[UILabel alloc]initWithFrame:CGRectMake(0, 410, 320, 20)];
        [weekendProject setText:@"My little weekend project with SpriteKit."];
        [weekendProject setTextColor:[UIColor whiteColor]];
        [weekendProject setTextAlignment:NSTextAlignmentCenter];
        [weekendProject setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0f]];
        [self addSubview:weekendProject];
        
        UILabel *tapPlay = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, 320, 20)];
        [tapPlay setText:@"(Tap icon to play.)"];
        [tapPlay setTextColor:[UIColor whiteColor]];
        [tapPlay setTextAlignment:NSTextAlignmentCenter];
        [tapPlay setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0f]];
        [self addSubview:tapPlay];

        
    }
    return self;
}

- (void)buttonSelected:(id)sender{
    
    if ([_delegate respondsToSelector:@selector(JSAppDisplayViewDidSelectAppWithIndex:)])
        [_delegate JSAppDisplayViewDidSelectAppWithIndex:((UIView *)sender).tag];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *lineOne = [UIBezierPath bezierPathWithRect: CGRectMake(18, 32, 284, 2)];
    [[UIColor whiteColor] setFill];
    [lineOne fill];
    
    UIBezierPath *lineTwo = [UIBezierPath bezierPathWithRect: CGRectMake(18, 205, 284, 2)];
    [[UIColor whiteColor] setFill];
    [lineTwo fill];
}


@end
