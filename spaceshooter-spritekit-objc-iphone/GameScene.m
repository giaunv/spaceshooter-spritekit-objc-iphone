//
//  GameScene.m
//  spaceshooter-spritekit-objc-iphone
//
//  Created by giaunv on 4/19/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
{
    SKSpriteNode *_ship;    //1
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        //2
        NSLog(@"SKScene:initWithSize %f x %f",size.width,size.height);
        
        //3
        self.backgroundColor = [SKColor blackColor];
        
#pragma mark - TBD - Game Backgrounds
        
#pragma mark - Setup Sprite for the ship
        //Create space sprite, setup position on left edge centered on the screen, and add to Scene
        //4
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"SpaceFlier_sm_1.png"];
        _ship.position = CGPointMake(self.frame.size.width * 0.1, CGRectGetMidY(self.frame));
        [self addChild:_ship];
        
#pragma mark - TBD - Setup the asteroids
        
#pragma mark - TBD - Setup the lasers
        
#pragma mark - TBD - Setup the Accelerometer to move the ship
        
#pragma mark - TBD - Setup the stars to appear as particles
        
#pragma mark - TBD - Start the actual game
        
    }
    return self;
}


-(void)update:(NSTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
