/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "GameOver.h"

@implementation HelloWorldLayer {
    
    CCNode *_leftBranch;
    CCNode *_rightBranch;
}
static const CGFloat pipeDistance = 140.f;
-(id) init
{
	if ((self = [super init]))
	{
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];
        
		// defining the background files
        background = [CCSprite spriteWithFile:@"gamebg.png"];
        bg2 = [CCSprite spriteWithFile:@"gamebg.png"];
        
        // Setting initial position of the backgrounds
        background.position = screenCenter;
        bg2.position = ccp(screenCenter.x,background.position.y-background.contentSize.height);
        
        //schedule to move background sprites
        [self schedule:@selector(scroll:)];
        
        //adding them to the main layer
        [self addChild:background z:0];
        [self addChild:bg2 z:0];
        
        // Setting the scrollSpeed (background moving speed)
        scrollSpeed = [[NSUserDefaults standardUserDefaults] integerForKey:@"scrollSpeed"];
        [[NSUserDefaults standardUserDefaults] setInteger:150 forKey:@"scrollSpeed"];
        
        //Score Display
        score = 0;
        scoreAdded = 1;
        scoreCounter = [NSString stringWithFormat:@"%i", score];
        scoreDisplay = [CCLabelTTF labelWithString:scoreCounter fontName:@"Pixelated" fontSize:50];
        scoreDisplay.color = ccc3(56, 56, 56);
        scoreDisplay.position = ccp(screenCenter.x,(screenSize.height * 7) / 8);
        [self addChild:scoreDisplay];
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(screenCenter.x, screenCenter.y);
        [self addChild:apple z:4];
        
        // Run the update method
        [self scheduleUpdate];

        dispatch_time_t countdown = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(countdown, dispatch_get_main_queue(), ^(void){
            [self spawnNewBranches];
            [self rewardPlayer];
        });
	}

	return self;
}

#pragma mark - Update

-(void) update:(ccTime)delta
{
    [self detectCollisions];
    [self grabTouchCoord];
    [self addPoint];
}

#pragma mark - Scrolling

-(void) scroll:(ccTime)dt
{
    // moves the bg
    background.position = ccp(screenCenter.x, background.position.y + [[NSUserDefaults standardUserDefaults] integerForKey:@"scrollSpeed"]*dt);
    bg2.position = ccp(screenCenter.x, (background.position.y-background.contentSize.height) + 1);
    
    // it adds the new bg's to the screen before the old bg's move off the screen
    if (background.position.y >= screenSize.height*1.5) {
        background.position = ccp(screenCenter.x, (screenCenter.y)-(background.size.height/2));
    } else if (bg2.position.y >= screenSize.height*1.5) {
        bg2.position = ccp(screenCenter.x, ((screenCenter.y)-(bg2.size.height/2))+1);
    }
    
    // moves the branches
    _rightBranch.position = ccp(_rightBranch.position.x, _rightBranch.position.y + (([[NSUserDefaults standardUserDefaults] integerForKey:@"scrollSpeed"]*2)*dt));
    _leftBranch.position = ccp(_leftBranch.position.x, _rightBranch.position.y);
    
    if (_rightBranch.position.y >= screenSize.height+10) {
        [self removeChild:_leftBranch cleanup:YES];
        [self removeChild:_rightBranch cleanup:YES];
        [self spawnNewBranches];
        [self rewardPlayer];
    }
    //
    if (_rightBranch.position.y >= apple.position.y) {
        [scoreDisplay setString:[NSString stringWithFormat:@"%i", score]];
//        [self schedule:@selector(addPoint)];
//        shouldScoreChange = YES;
    }
//    else if (_leftBranch.position.y == screenCenter.y + 20){
//        shouldScoreChange = NO;
//    }
}

#pragma mark - Game Actions

-(void) grabTouchCoord {
    // Methods that should run every frame here!
    KKInput *input = [KKInput sharedInput];
    //This will be true as long as there is at least one finger touching the screen
    if(input.touchesAvailable) {
        
        posTouchScreen = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        coord = posTouchScreen;
        CGPoint newpos = posTouchScreen;
        CGPoint oldpos = [apple position];
        
        if(newpos.x - oldpos.x > 5 || newpos.x - oldpos.x < -5 || newpos.y - oldpos.y > 5 || newpos.y - oldpos.y < -5) {
            apple.position = ccp(coord.x, apple.position.y);
            //            CCSequence *boo = [CCSequence actions:[CCMoveTo actionWithDuration:2.0f position:ccp(coord.x, apple.position.y)], nil];
            //            [apple runAction:boo];
        }
    }
}

- (void)addPoint
{
//    if (shouldScoreChange == YES) {
//        shouldScoreChange = NO;
//        score += 1/50;
//        [scoreDisplay setString:[NSString stringWithFormat:@"%i", score]];
//    }
    if (score < targetScore) {
        int increment = ((targetScore) - score);
        if (increment < 1) {
            increment = 0;
        }
        score += increment;
    }

}
-(void) rewardPlayer
{
    targetScore = score + scoreAdded;
}

#pragma mark - Obstacle Spawning

- (void)spawnNewBranches {
    
    int fromNumber = 220;
    int toNumber = 480;
    int randomNumber = (arc4random()%(toNumber-fromNumber))+fromNumber;
        
    _leftBranch = [CCSprite spriteWithFile:@"branch.png"];
    _rightBranch = [CCSprite spriteWithFile:@"branch.png"];
    
    _rightBranch.position = ccp(randomNumber, (screenCenter.y/30)-50);
//    _leftBranch.position = ccp((toNumberForLeft * 1.5) + ((_rightBranch.position.x/2)-pipeDistance), _rightBranch.position.y);
    _leftBranch.position = ccp(((_rightBranch.position.x/2)-(pipeDistance * 1.5)), _rightBranch.position.y);

    
    [self addChild:_rightBranch z:3];
    [self addChild:_leftBranch z:3];
}

#pragma mark - Detect Collisions

-(void) detectCollisions
{
        if (CGRectIntersectsRect([_leftBranch boundingBox], [apple boundingBox]) == true || CGRectIntersectsRect([_rightBranch boundingBox], [apple boundingBox]) == true) {
            [self pauseSchedulerAndActions];
            
            // Set up the score
            [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"theScore"];
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:0.5f scene:[GameOver node]]];
        }
}

@end
