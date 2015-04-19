//
//  GameScene.m
//  spaceshooter-spritekit-objc-iphone
//
//  Created by giaunv on 4/19/15.
//  Copyright (c) 2015 366. All rights reserved.
//

@import CoreMotion;
#import "GameScene.h"
#import "FMMParallaxNode.h"

@implementation GameScene
{
    SKSpriteNode *_ship;    //1
    FMMParallaxNode *_parallaxNodeBackgrounds;
    FMMParallaxNode *_parallaxSpaceDust;
    CMMotionManager *_motionManager;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        //2
        NSLog(@"SKScene:initWithSize %f x %f",size.width,size.height);
        
        //3
        self.backgroundColor = [SKColor blackColor];
        
#pragma mark - TBD - Game Backgrounds
        NSArray *parallaxBackgroundNames = @[@"bg_galaxy.png", @"bg_planetsunrise.png",@"bg_spacialanomaly.png", @"bg_spacialanomaly2.png"];
        CGSize planetSizes = CGSizeMake(200.0, 200.0);
        _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackgroundNames size:planetSizes pointsPerSecondSpeed:10.0];
        _parallaxNodeBackgrounds.position = CGPointMake(size.width/2.0, size.height/2.0);
        [_parallaxNodeBackgrounds randomizeNodesPositions];
        [self addChild:_parallaxNodeBackgrounds];
        
        NSArray *parallaxBackground2Names = @[@"bg_front_spacedust.png",@"bg_front_spacedust.png"];
        _parallaxSpaceDust = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackground2Names size:size pointsPerSecondSpeed:25.0];
        _parallaxSpaceDust.position = CGPointMake(0, 0);
        [self addChild:_parallaxSpaceDust];
        
#pragma mark - Setup Sprite for the ship
        //Create space sprite, setup position on left edge centered on the screen, and add to Scene
        //4
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"SpaceFlier_sm_1.png"];
        _ship.position = CGPointMake(self.frame.size.width * 0.1, CGRectGetMidY(self.frame));
        [self addChild:_ship];
        
#pragma mark - TBD - Setup the asteroids
        
#pragma mark - TBD - Setup the lasers
        
#pragma mark - TBD - Setup the Accelerometer to move the ship
        
        _motionManager = [[CMMotionManager alloc] init];
        
#pragma mark - TBD - Setup the stars to appear as particles
        
        [self addChild:[self loadEmitterNode:@"stars1"]];
        [self addChild:[self loadEmitterNode:@"stars2"]];
        [self addChild:[self loadEmitterNode:@"stars3"]];
        
#pragma mark - TBD - Start the actual game
        
        [self startTheGame];
        
    }
    return self;
}


-(void)update:(NSTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    // Update background (parallax) position
    [_parallaxSpaceDust update:currentTime];
    [_parallaxNodeBackgrounds update:currentTime];
    [self updateShipPositionFromMotionManager];
}

-(SKEmitterNode *)loadEmitterNode:(NSString *)emitterFileName{
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:emitterFileName ofType:@"sks"];
    SKEmitterNode *emitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    
    // do some view specific tweaks
    emitterNode.particlePosition = CGPointMake(self.size.width/2.0, self.size.height/2.0);
    emitterNode.particlePositionRange = CGVectorMake(self.size.width+100, self.size.height);
    
    return emitterNode;
}

-(void)startTheGame{
    _ship.hidden = NO;
    
    // reset ship position for new game
    _ship.position = CGPointMake(self.frame.size.width * 0.1, CGRectGetMidY(self.frame));
    
    // setup to handle accelerometer readings using CoreMotion Framework
    [self startMonitoringAcceleration];
}

-(void)startMonitoringAcceleration{
    if (_motionManager.accelerometerAvailable) {
        [_motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
}

-(void)stopMonitoringAcceleration{
    if (_motionManager.accelerometerAvailable && _motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
        NSLog(@"accelerometer updates off...");
    }
}

-(void)updateShipPositionFromMotionManager{
    CMAccelerometerData *data = _motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        NSLog(@"acceleration value = %f", data.acceleration.x);
    }
}
@end
