//
//  JSMainViewController.h
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-08.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "JSTransitionImageView.h"

//Content Views
#import "JSIntroductionView.h"
#import "JSAppsDisplayView.h"

#import "JSFlappyChickenController.h"
#import "JSDetailViewController.h"
@interface JSMainViewController : UIViewController <UIScrollViewDelegate, JSAppsDisplayViewDelegate>

@property (nonatomic, strong) UIScrollView *baseScrollView;

//Array to store and access content views
@property (nonatomic, strong) NSMutableArray *contentViewStack;
@property (nonatomic, strong) NSMutableArray *textLabelStack;

@property (nonatomic, strong) NSArray *backgroundImageNames;

- (void)createContentViewStack;

- (void)returnToTop;

@end
