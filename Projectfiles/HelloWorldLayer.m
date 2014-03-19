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
static const CGFloat pipeDistance = 150.f;

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
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(screenCenter.x, screenCenter.y);
        [self addChild:apple z:4];
        
        appleLeft = NO;
        appleRight = NO;
        
        CCLabelTTF *right = [CCLabelTTF labelWithString:@"Right" fontName:@"Arial" fontSize:40];
        CCLabelTTF *left = [CCLabelTTF labelWithString:@"Left" fontName:@"Arial" fontSize:40];
        
        CCMenuItemLabel *starMenuItem = [CCMenuItemLabel itemWithLabel:right target:self selector:@selector(rightButtonPushed)];
        CCMenuItemLabel *starMenuItemTwo = [CCMenuItemLabel itemWithLabel:left target:self selector:@selector(leftButtonPushed)];
        
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItemTwo, starMenuItem, nil];
        starMenu.position = ccp(screenCenter.x, screenCenter.y-200);
        [starMenu alignItemsHorizontallyWithPadding:12];
        [self addChild:starMenu];
        
        // Run the update method
        [self scheduleUpdate];

        dispatch_time_t countdown = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(countdown, dispatch_get_main_queue(), ^(void){
            [self spawnNewBranches];
        });
	}

	return self;
}

#pragma mark - Update

-(void) update:(ccTime)delta
{
    if (appleRight == TRUE) {
        apple.position = ccp(apple.position.x + 1*delta, screenCenter.y);
        //        appleRight = FALSE;
    } else if (appleLeft== TRUE) {
        apple.position = ccp(apple.position.x - 1*delta, screenCenter.y);
        //        appleLeft = FALSE;
    }
    [self detectCollisions];
    [self grabTouchCoord];
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
    }
}

#pragma mark - Game Actions

-(void) rightButtonPushed {
//    appleRight = TRUE;
    id actionMove = [CCMoveTo actionWithDuration:0.1 position:ccp(apple.position.x + 12, screenCenter.y)];
    [apple runAction:actionMove];
}

-(void) leftButtonPushed {
//    appleLeft = TRUE;
    id actionMove = [CCMoveTo actionWithDuration:0.1 position:ccp(apple.position.x - 12, screenCenter.y)];
    [apple runAction:actionMove];

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
    _leftBranch.position = ccp(((_rightBranch.position.x/2)-pipeDistance), _rightBranch.position.y);

    
    [self addChild:_rightBranch z:3];
    [self addChild:_leftBranch z:3];
}

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


#pragma mark - Detect Collisions

-(void) detectCollisions
{
        if (CGRectIntersectsRect([_leftBranch boundingBox], [apple boundingBox]) == true || CGRectIntersectsRect([_rightBranch boundingBox], [apple boundingBox]) == true) {
            [self pauseSchedulerAndActions];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:0.5f scene:[GameOver node]]];
        }
}

@end
