//
//  JSAppsDisplayView.h
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-12.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface JSAppsDisplayView : UIView

@property (weak, readwrite) id delegate;

@end

@protocol JSAppsDisplayViewDelegate <NSObject>

- (void)JSAppDisplayViewDidSelectAppWithIndex:(NSInteger)index;

@end
