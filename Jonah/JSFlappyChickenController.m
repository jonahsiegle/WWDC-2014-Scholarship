//
//  JSFlappyChickenController.m
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-14.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "JSFlappyChickenController.h"

@interface JSFlappyChickenController ()

@end

@implementation JSFlappyChickenController{
    UILabel *loadingLabel;
    
    UIButton *backButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loadingLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [loadingLabel setText:@"Loading Scene..."];
    [loadingLabel setNumberOfLines:0];
    [loadingLabel setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f]];
    [loadingLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [loadingLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:loadingLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 64, 64)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self reloadSceneInstance];
    [loadingLabel setHidden:true];
}

- (void)viewDidDisappear:(BOOL)animated{
    [((SKView *)self.view).scene removeAllActions];
    [((SKView *)self.view).scene removeAllChildren];
    self.view = nil;
}

- (void)loadView{
    [super loadView];
    
    self.view = [[SKView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
}

- (void)reloadSceneInstance{
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = FALSE;
    skView.showsNodeCount = false;
    
    CGSize sceneSize = skView.bounds.size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        sceneSize = CGSizeMake(420, 560);
    
    // Create and configure the scene.
    MyScene * scene = [MyScene sceneWithSize:sceneSize];
    scene.delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:scene];
    
}



#pragma mark - Scene Delegate
- (void)gameOverWithScene:(SKScene *)scene{
    [self reloadSceneInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
