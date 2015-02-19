//
//  MyScene.h
//  Bounce
//

//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode *player;

@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) BOOL dead;
@property (nonatomic, assign) BOOL playing;
@property (nonatomic, assign) BOOL hitCrate;
@property (nonatomic, assign) BOOL hitGround;

@property (nonatomic, assign) BOOL gameOverScreen;

@property (weak, readwrite) id delegate;

@end

@protocol SceneDelegate <NSObject>

- (void)gameOverWithScene:(SKScene *)scene;
- (void)gameDidStartWithScene:(SKScene *)scene;

@end
