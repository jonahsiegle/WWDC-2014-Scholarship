//
//  MyScene.m
//  Bounce
//
//  Created by Jonah Siegle on 2/11/2014.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "MyScene.h"



//Bitmasks
static const uint32_t birdCategory = 0x1 << 0;
static const uint32_t pipeCategory = 0x1 << 1;
static const uint32_t spaceCategory = 0x1 << 3;

static const uint32_t groundCategory = 0x1 << 2;

@implementation MyScene{
    
    CGFloat spaceCounter;
    
    SKSpriteNode *baseGround;
    
    SKSpriteNode *title;
    SKLabelNode *tapToStart;
    
    SKLabelNode *scoreLabel;
    
    SKLabelNode *bestScoreLabel;
    
    SKAction *startSound;
    
    
    SKSpriteNode *highScoreButton;
    
    SKSpriteNode *volumeToggle;
    
    
    NSInteger spawnCount;
    
    
    BOOL canFlyDown;
    BOOL isFlyingDown;
    
    float resizeAmount;
    BOOL shouldResize;
    
    BOOL isiPad;
}

@synthesize paused = _paused;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        

        isiPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);

        
        resizeAmount = (self.size.height - 480);
        shouldResize = (resizeAmount == 0) ? false : true;
        
     //   shouldResize = false;
        
        self.backgroundColor = [SKColor colorWithRed:0.33 green:0.79 blue:0.91 alpha:1];
        
        self.physicsWorld.gravity = CGVectorMake(0, -5.5);
        self.physicsWorld.contactDelegate = self;
        
        _player = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"cclosed.png"]] size:CGSizeMake(39, 33)];
        _player.position = CGPointMake(100, shouldResize ? 134.0f : 46.0f);
        //_player.physicsBody.usesPreciseCollisionDetection = true;
        
        _player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:15];
        _player.physicsBody.dynamic = true;
       // player.physicsBody.mass = 1;
        _player.physicsBody.restitution = 1;
        _player.physicsBody.linearDamping = 0;
        _player.physicsBody.angularDamping = 0;
        _player.physicsBody.categoryBitMask = birdCategory;
        _player.physicsBody.collisionBitMask = groundCategory;
        _player.physicsBody.contactTestBitMask = pipeCategory | groundCategory;
        
        _player.physicsBody.affectedByGravity = FALSE;
        
        [self addChild:_player];
        
        
        SKNode *edgeNode = [SKNode node];
        
        [edgeNode setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:
                                  CGRectMake(0.0, shouldResize ? 110 : 22, size.width, size.height)]];
        
       // [edgeNode.physicsBody setUsesPreciseCollisionDetection:YES];
        [edgeNode.physicsBody setCategoryBitMask:groundCategory];
        [edgeNode.physicsBody setCollisionBitMask:birdCategory];
       // [edgeNode.physicsBody setContactTestBitMask:birdCategory];
        
        [self addChild:edgeNode];
        
        CGSize grassSize = CGSizeMake((isiPad ? 480 : 320) + 200, 118);
        
        baseGround = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"grass.png"]] size:grassSize];
        baseGround.position = CGPointMake(isiPad ? ((self.frame.size.width +200 + 60)/2) : (self.frame.size.width +200)/2, shouldResize ? baseGround.size.height/2 : -29);
        
//        baseGround.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:baseGround.size];
//        baseGround.physicsBody.dynamic = false;
//        baseGround.physicsBody.categoryBitMask = groundCategory;
//        baseGround.physicsBody.contactTestBitMask = birdCategory;
//        baseGround.physicsBody.collisionBitMask = birdCategory;
//        baseGround.physicsBody.affectedByGravity = false;
//        
        [self addChild:baseGround];
        
        //Setup inital scene
        SKSpriteNode *nestNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"nest.png"]] size:CGSizeMake(44, 15)];
        nestNode.position = CGPointMake(-159 + (isiPad ? -80.0f: 0.0f), ((baseGround.size.height/2) + nestNode.size.height/2)-2.5);
        nestNode.zPosition = 1;
        
        [baseGround addChild:nestNode];
        
        SKSpriteNode *bladeOne = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"element1.png"]] size:CGSizeMake([UIImage imageNamed:@"element1.png"].size.width/2, [UIImage imageNamed:@"element1.png"].size.height/2)];
        bladeOne.zPosition = 1;
        bladeOne.position = CGPointMake(-210 + (isiPad ? -80.0f: 0.0f), ((baseGround.size.height/2) + bladeOne.size.height/2)-2.5);
        [baseGround addChild:bladeOne];
        
        SKSpriteNode *bladeTwo = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"element2.png"]] size:CGSizeMake([UIImage imageNamed:@"element2.png"].size.width/2, [UIImage imageNamed:@"element2.png"].size.height/2)];
        bladeTwo.zPosition = 1;
        bladeTwo.position = CGPointMake(-100 + (isiPad ? -80.0f: 0.0f), ((baseGround.size.height/2) + bladeTwo.size.height/2)-2.5);
        [baseGround addChild:bladeTwo];
        
        SKSpriteNode *bladeThree = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"element1.png"]] size:CGSizeMake([UIImage imageNamed:@"element1.png"].size.width/2, [UIImage imageNamed:@"element1.png"].size.height/2)];
        bladeThree.zPosition = 1;
        bladeThree.position = CGPointMake(-60 + (isiPad ? -80.0f: 0.0f), ((baseGround.size.height/2) + bladeThree.size.height/2)-2.5);
        [baseGround addChild:bladeThree];
        
        //Labels
//        
        title = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"flappy-chicken.png"]] size:CGSizeMake(323/2, 164/2)];
        title.position = CGPointMake(self.scene.frame.size.width/2, (self.scene.frame.size.height/2 + 50.0f) + (resizeAmount-20.0f) + (shouldResize ? 0 : 40.0f));
        [self addChild:title];
        
        
        volumeToggle = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed: [[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"] ? @"volumeoff.png" : @"volumeon.png"]] size:CGSizeMake(38.0f, 37.0f)];
        volumeToggle.position = CGPointMake(self.scene.size.width - 30.0f, self.scene.size.height - 30.0f);
        volumeToggle.name = @"sound";

        [self addChild:volumeToggle];
        
        tapToStart = [SKLabelNode labelNodeWithFontNamed:@"04b19"];
        tapToStart.position = CGPointMake(self.scene.frame.size.width/2, (self.scene.frame.size.height/2 - 50.0f) + (resizeAmount-20.0f) + (shouldResize ? 0 : 40.0f));
        tapToStart.fontSize = 24.0f;
        tapToStart.text = @"TAP TO START";
        [self addChild:tapToStart];
        
        
        SKAction *fadeInOutAction = [SKAction sequence:@[[SKAction fadeAlphaTo:0.4f duration:1.0f], [SKAction fadeAlphaTo:1.0f duration:1.0f]]];
        [tapToStart runAction:[SKAction repeatActionForever:fadeInOutAction]];
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"04b19"];
        scoreLabel.position = CGPointMake(self.scene.frame.size.width/2, self.scene.frame.size.height - 70.0f);
        scoreLabel.fontSize = 36.0f;
        scoreLabel.text = @"0";
        scoreLabel.alpha = 0.0f;
        [self addChild:scoreLabel];
        
        
        //Best score label
        NSInteger scoreLabelValue = 0;
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Score"] != nil){
            scoreLabelValue = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"Score"]] intValue];
        }
        
        
        startSound = [SKAction playSoundFileNamed:@"point.mp3" waitForCompletion:NO];
        
        [self breatheBird];
        
//        //Highscore button
//        highScoreButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"highscore_button.png"]] size:CGSizeMake(121, 37)];
//        highScoreButton.position = CGPointMake(self.scene.size.width/2, (self.scene.size.height/2 - 100.0f) + (resizeAmount-20.0f) + (shouldResize ? 0 : 40.0f));
//        highScoreButton.name = @"highscore";
//        [self addChild:highScoreButton];
        
    }
    return self;
}

- (void)breatheBird{
    
    [_player runAction:[SKAction moveByX:0.0f y:1.0f duration:1.0f] completion:^{
        
        [_player runAction:[SKAction moveByX:0.0f y:-1.0f duration:1.0f] completion:^{
            [self breatheBird];
            
        }];
    }];

}

- (void)start{
    
    if ([_delegate respondsToSelector:@selector(gameDidStartWithScene:)])
        [_delegate performSelector:@selector(gameDidStartWithScene:) withObject:self];
//
    [tapToStart removeAllActions];
    
    [volumeToggle runAction:[SKAction fadeOutWithDuration:0.2f]];
    [title runAction:[SKAction fadeOutWithDuration:0.2f]];
    [tapToStart runAction:[SKAction fadeOutWithDuration:0.2f]];
    [highScoreButton runAction:[SKAction fadeOutWithDuration:0.2f] completion:^{
        [highScoreButton removeFromParent];
    }];

    [scoreLabel runAction:[SKAction fadeInWithDuration:0.2f]];

    [_player removeAllActions];
    
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(-baseGround.size.width/2,  shouldResize ? baseGround.size.height/2: -29) duration:isiPad ? 4.2f : 3.63f];
    [baseGround runAction:moveAction];
    [self callNewGround];
    
    
}


//- (void)pause{
//    
//    if (_player.isValid)
//        [_player invalidate];
//    
//    if (_player.isValid)
//         [_spaceTimer invalidate];
//    
//    
//    for (SKSpriteNode *sprite in self.children){
//        [sprite removeAllActions];
//    }
//        
//    
//}

//- (void)resume{
//    
//    //Re add actions
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, spaceCounter * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        
//        spaceCounter = 2.0f;
//        [self spawnPipe];
//        
////        _spawnTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(spawnPipe) userInfo:nil repeats:YES];
////        [_spawnTimer fire];
////        
////        _spaceTimer = [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(updateSpace) userInfo:nil repeats:YES];
//        
//    });
//
//}

- (void)gameOver{
    
//Game over stuff
    
    //Buttons
    SKSpriteNode *restartButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"restart"]] size:CGSizeMake(131, 37)];
    restartButton.position = CGPointMake((self.scene.size.width/2) - 79.5, ((self.scene.size.height + (shouldResize ? baseGround.size.height : 0))/2) - 110.f);
    restartButton.alpha = 0.0f;
    restartButton.name = @"restartbutton";
    [self addChild:restartButton];
    
    SKSpriteNode *shareButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"share"]] size:CGSizeMake(131, 37)];
    shareButton.position = CGPointMake((self.scene.size.width/2) + 79.5, ((self.scene.size.height + (shouldResize ? baseGround.size.height : 0))/2) - 110.f);
    shareButton.alpha = 0.0f;
    shareButton.name = @"sharebutton";
    [self addChild:shareButton];

    
    [scoreLabel runAction:[SKAction fadeOutWithDuration:0.1]];
    
    SKSpriteNode *board = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"scoreboard.png"]] size:CGSizeMake(290, 170)];
    board.position = CGPointMake(self.scene.size.width/2, 0 - 170/2);
    board.zPosition = 2.0;
    [self addChild:board];
    
    [board runAction:[SKAction moveTo:CGPointMake(self.scene.size.width/2, (self.scene.size.height + (shouldResize ? baseGround.size.height : 0))/2) duration:0.35f] completion:^{
        
        [restartButton runAction:[SKAction fadeInWithDuration:0.3f]];
        [shareButton runAction:[SKAction fadeInWithDuration:0.3f]];
    }];
    
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"04B19"];
    gameOver.position = CGPointMake(0, 50.0f);
    gameOver.fontSize = 24.0f;
    gameOver.text = @"GAME OVER";

    [board addChild:gameOver];
    

    SKLabelNode *yourScore = [SKLabelNode labelNodeWithFontNamed:@"04B19"];
    yourScore.position = CGPointMake(0, 10.0f);
    yourScore.fontSize = 20.0f;
    yourScore.text = [NSString stringWithFormat:@"SCORE: %@",scoreLabel.text];
    
    [board addChild:yourScore];
    
   NSInteger bestScoreInt = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"Score"]] integerValue];
    
    
    SKLabelNode *bestScore = [SKLabelNode labelNodeWithFontNamed:@"04B19"];
    bestScore.position = CGPointMake(0, -25.0f);
    bestScore.fontSize = 20.0f;
    bestScore.text = [NSString stringWithFormat:@"BEST: %li",(long)bestScoreInt];
    
    [board addChild:bestScore];
    
    
    if (scoreLabel.text.integerValue > bestScoreInt){
        
        bestScore.text = [NSString stringWithFormat:@"BEST: %li",(long)scoreLabel.text.integerValue];
        
        NSData *newScore = [NSKeyedArchiver archivedDataWithRootObject:scoreLabel.text];
        
        [[NSUserDefaults standardUserDefaults]setObject:newScore forKey:@"Score"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        NSLog(@"new highscore");
    
        SKLabelNode *newLabel = [SKLabelNode labelNodeWithFontNamed:@"04B19"];
        newLabel.position = CGPointMake(0, -45.0f);
        newLabel.fontSize = 16.0f;
        newLabel.fontColor = [UIColor colorWithRed:1 green:0.23 blue:0.11 alpha:1];
        newLabel.text = @"NEW";
        
        [board addChild:newLabel];
    }
    
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    

    if ([node.name isEqualToString:@"highscore"]) {
        NSLog(@"High Score");
    
        
        

    }else if ([node.name isEqualToString:@"restartbutton"]) {
        if ([_delegate respondsToSelector:@selector(gameOverWithScene:)])
            [_delegate performSelector:@selector(gameOverWithScene:) withObject:self];

        
    }else if ([node.name isEqualToString:@"sound"]) {
        
        BOOL soundMuted = [[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"];
        
        [[NSUserDefaults standardUserDefaults]setBool:!soundMuted forKey:@"Mute Sounds"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [volumeToggle setTexture:[SKTexture textureWithImage:[UIImage imageNamed: [[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"] ? @"volumeoff.png" : @"volumeon.png"]]];
        
    }else if ([node.name isEqualToString:@"sharebutton"]) {
        
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:@"I just scored %@ points in Flappy Chicken! How far can you flap? #flappychicken http://bit.ly/getflpychckn", scoreLabel.text]]
                                                                         applicationActivities:nil];
        [_delegate presentViewController:vc animated:YES completion:NULL];
        
    }else{
    
        if (!_gameOverScreen){
        
            if (!_dead){

                if (!_playing){
                    [self start];
                    [self animateBird];
                    
                    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"])
                        [self runAction:startSound];

                    
                }else{
                    
                    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"])
                        [self runAction:[SKAction playSoundFileNamed:@"jump.mp3" waitForCompletion:YES]];

                }
                
                if (_player.position.y < (self.scene.size.height-30))
                    [self flap];
                
                
                _playing = TRUE;

            }
            
        }
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_playing)
        [self performSelector:@selector(flyDown) withObject:nil afterDelay:0.5f];
}

- (void)animateBird{
    
    NSArray *framesToAnimate = @[[SKTexture textureWithImage:[UIImage imageNamed:@"cmid.png"] ], [SKTexture textureWithImage:[UIImage imageNamed:@"ctop.png"]], [SKTexture textureWithImage:[UIImage imageNamed:@"cmid.png"]], [SKTexture textureWithImage:[UIImage imageNamed:@"cbtm.png"]]];
    [_player runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesToAnimate timePerFrame:0.1f resize:false restore:YES]]];
}

- (void)flyDown{
    
    if (!isFlyingDown && !_dead){
        isFlyingDown = TRUE;

        SKAction *rotateDown = [SKAction rotateToAngle:-M_PI/ 2.0f duration:0.4];
        [_player runAction:rotateDown withKey:@"flydown"];
    }

}

- (void)flap{
    
    
    _player.physicsBody.affectedByGravity = TRUE;
    _player.physicsBody.velocity = CGVectorMake(0, 0);
    [_player.physicsBody applyImpulse:CGVectorMake(0, (_playing) ? 8.0 : 15)];
    
    [_player removeActionForKey:@"flydown"];
    
    SKAction *rotate = [SKAction rotateToAngle:M_PI/ 6.0f duration:0.2];
    [_player runAction:rotate];
    
    canFlyDown = FALSE;
    isFlyingDown = FALSE;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(flyDown) object:nil];
    
}

- (void)callNewGround{

    
    if (!_dead){
        
    
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"grass"]] size:CGSizeMake(320 + 200, 118)];
        ground.position = CGPointMake((self.frame.size.width + 200)*1.5, shouldResize ? baseGround.size.height/2: -29);
        
        
       // [self addChild:ground];
        
        [self performSelectorOnMainThread:@selector(addChild:) withObject:ground waitUntilDone:FALSE];
        
//        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
//        ground.physicsBody.categoryBitMask = groundCategory;
//        ground.physicsBody.collisionBitMask = 0;
//        ground.physicsBody.contactTestBitMask = birdCategory;
//        ground.physicsBody.affectedByGravity = false;
//        ground.physicsBody.friction = 0.4f;
    //    ground.physicsBody.dynamic = false;
     //   ground.physicsBody.usesPreciseCollisionDetection = TRUE;
        
        ground.name = @"ground";
        
        
        //Add new elements 2/3 times
        if ((arc4random() % 3)!=1){
            
            NSInteger randomNumber = (arc4random() % 2)+1;
            
            UIImage *randomImage = [UIImage imageNamed:[NSString stringWithFormat:@"element%li", (long)randomNumber]];
            
            int minPos = 0.0;
            int maxPos = 150;
            int range = maxPos - minPos;
            int yRange = (arc4random() % range) + minPos;
            
            SKSpriteNode *element = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:randomImage] size:CGSizeMake(randomImage.size.width/2, randomImage.size.height/2)];
            element.zPosition = 1;
            element.position = CGPointMake(-100, ((ground.size.height/2) + element.size.height/2)-2.5);
            //[ground addChild:element];
            [ground performSelectorOnMainThread:@selector(addChild:) withObject:element waitUntilDone:FALSE];

            
            
            //Spawn Additional 50/50 chance
            if ((arc4random() % 2) != 0){
                
                NSInteger randomNumberA = (arc4random() % 2)+1;
                
                UIImage *randomImageA = [UIImage imageNamed:[NSString stringWithFormat:@"element%li", (long)randomNumberA]];
                
                int minPosA = 0.0;
                int maxPosA = 150;
                int rangeA = maxPosA - minPosA;
                int yRangeA = (arc4random() % rangeA) + minPosA;
                
                
                if (ABS(yRangeA - yRange)< 45){
                    yRangeA += 45;
                }
                
                SKSpriteNode *elementA = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:randomImage] size:CGSizeMake(randomImage.size.width/2, randomImageA.size.height/2)];
                elementA.zPosition = 1;
                elementA.position = CGPointMake(-100, ((ground.size.height/2) + elementA.size.height/2)-2.5);
              //  [ground addChild:elementA];
                [ground performSelectorOnMainThread:@selector(addChild:) withObject:elementA waitUntilDone:FALSE];


            }
            

        }
        
        
        //Add Pipe (Crates)
        
        SKSpriteNode *pipeBottom = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"stack.png"]] size:CGSizeMake(75, 450)];
        
        pipeBottom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipeBottom.size];
        pipeBottom.physicsBody.categoryBitMask = pipeCategory;
        pipeBottom.physicsBody.contactTestBitMask = birdCategory;
        pipeBottom.physicsBody.collisionBitMask = 0;
        pipeBottom.physicsBody.affectedByGravity = false;
        
        int minPos = 1.0;
        int maxPos = 5.0f;
        int range = maxPos - minPos;
        int yRange = (arc4random() % range) + minPos;

        pipeBottom.zPosition = -1;
        pipeBottom.position = CGPointMake(0, ((ground.size.height/2 - 4) - 225) + (74 * yRange));
        
      //  [ground addChild:pipeBottom];
        [ground performSelectorOnMainThread:@selector(addChild:) withObject:pipeBottom waitUntilDone:FALSE];

        
        
        SKSpriteNode *hole = [[SKSpriteNode alloc]initWithTexture:nil color:[UIColor clearColor] size:CGSizeMake(20, 80)];
        hole.position = CGPointMake(0, (-200.0f)+(80.0f *yRange) + 83 + 480 - 281);
        
        hole.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hole.size];
        hole.physicsBody.categoryBitMask = spaceCategory;
        hole.physicsBody.contactTestBitMask = birdCategory;
        hole.physicsBody.collisionBitMask = 0;
        hole.physicsBody.affectedByGravity = false;
       // [ground addChild:hole];
        
        [ground performSelectorOnMainThread:@selector(addChild:) withObject:hole waitUntilDone:FALSE];

        
        
        
        SKSpriteNode *pipeTop = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"stack.png"]] size:CGSizeMake(75, 450)];
        
        pipeTop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipeBottom.size];
        pipeTop.physicsBody.categoryBitMask = pipeCategory;
        pipeTop.physicsBody.contactTestBitMask = birdCategory;
        pipeTop.physicsBody.collisionBitMask = 0;
        pipeTop.physicsBody.affectedByGravity = false;
        
        pipeTop.zPosition = -1;
        pipeTop.position = CGPointMake(0, ((ground.size.height/2 - 4) - 225) + (74 * yRange) + 83 + 450);
        //[ground addChild:pipeTop];
        
        [ground performSelectorOnMainThread:@selector(addChild:) withObject:pipeTop waitUntilDone:FALSE];

        
        

        SKAction *moveAction = [SKAction moveTo:CGPointMake(-ground.frame.size.width/2,  shouldResize ? baseGround.size.height/2: -29) duration:7.26f];
        [ground runAction:moveAction completion:^{
            [ground removeFromParent];
            
        }];
        
        //[self performSelector:@selector(callNewGround) withObject:nil afterDelay:2.2f];
        
        double delayInSeconds = 2.2f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self performSelectorInBackground:@selector(callNewGround) withObject:nil];

        });
        
    
}


}

- (void)setDead:(BOOL)dead{
    
    _dead = dead;
    
    
    for (SKSpriteNode *node in self.children){
        
        [node removeAllActions];
        
    }
    
    _player.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"cmid.png"]];
}

- (void)shakeScreen{
    
    
    //White Flash
    SKSpriteNode *flash = [[SKSpriteNode alloc]initWithColor:[UIColor whiteColor] size:self.scene.size];
    flash.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
    flash.alpha = 0.0f;
    [self addChild:flash];
    
    [flash runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.7f duration:0.1], [SKAction fadeOutWithDuration:0.1]]]];
    
    SKAction *shakeRight = [SKAction moveByX:5 y:2 duration:0.025];
    SKAction *shakeLeft = [SKAction moveByX:-5 y:-2 duration:0.025];
    
    SKAction *screenShake = [SKAction sequence:@[shakeRight, shakeRight.reversedAction, shakeLeft, shakeLeft.reversedAction]];
    
    [self runAction:[SKAction repeatAction:screenShake count:3]];

}

#pragma mark - Collision Detection


- (void)didBeginContact:(SKPhysicsContact *)contact{

    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & birdCategory) != 0 &&
        (secondBody.categoryBitMask & pipeCategory) != 0)
    {
        
        if (!_dead){

            [self setDead:TRUE];
            [self shakeScreen];
            

            
            if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"])
                [self runAction:[SKAction playSoundFileNamed:@"death.mp3" waitForCompletion:NO]];

            
            [_player.physicsBody applyImpulse:CGVectorMake(0.0f, 5.0f)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                if (!_hitGround){
                    SKAction *rotateDown = [SKAction rotateToAngle:-M_PI/ 2.0f duration:0.4];
                    [self.player runAction:rotateDown];
                }

            });

        
            _hitCrate = TRUE;
        }
    }else if ((firstBody.categoryBitMask & birdCategory) != 0 &&
                  (secondBody.categoryBitMask & groundCategory) != 0){
        
        _hitGround = TRUE;
        [self setDead:TRUE];
        
        if (!_hitCrate){
            


            [self shakeScreen];
            
            if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"])
                [self runAction:[SKAction playSoundFileNamed:@"death.mp3" waitForCompletion:NO]];

            
        }
        
        //Maybe a tiny delay
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self gameOver];

        });
        
        _player.physicsBody.affectedByGravity = FALSE;
        _player.physicsBody.dynamic = FALSE;
        
        self.physicsWorld.contactDelegate = nil;
        
//        //Dirty but it works
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        });


    }else if ((firstBody.categoryBitMask & birdCategory) != 0 &&
              (secondBody.categoryBitMask & spaceCategory) != 0){
        

        
        if (!_dead){
            scoreLabel.text = [NSString stringWithFormat:@"%i", [scoreLabel.text intValue]+1];
        
            if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Mute Sounds"])
                [self runAction:[SKAction playSoundFileNamed:@"point.mp3" waitForCompletion:NO]];
            
        }

        
        //Grab Score
        NSInteger bestScore = 0;
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Score"] != nil){
            bestScore = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"Score"]] intValue];
        }
        
        if ([scoreLabel.text intValue] > bestScore){
            

        }
        
    }

}

- (void)didEndContact:(SKPhysicsContact *)contact{

}

- (void)setPaused:(BOOL)paused{
    _paused = paused;

}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
//    if ((_player.position.y -_player.size.height/2)>=(baseGround.position.y + baseGround.size.height/2) && (_player.position.y -_player.size.height/2)<=(baseGround.position.y + baseGround.size.height/2)+5){
//        
//        _player.position = CGPointMake(100, (baseGround.position.y + (baseGround.size.height/2)+_player.size.height/2)+5);
//    }
    

}




@end
