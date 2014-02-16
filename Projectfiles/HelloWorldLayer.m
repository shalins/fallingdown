/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"

static const CGFloat firstBranchPosition = 280.f;
static const CGFloat distanceBetweenBranches = 160.f;

typedef NS_ENUM(NSInteger, DrawingOrder) {
    DrawingOrderPipes,
};

@implementation HelloWorldLayer

-(id) init
{
	if ((self = [super init]))
	{
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];
        
		// defining the background files
        background = [CCSprite spriteWithFile:@"background.png"];
        bg2 = [CCSprite spriteWithFile:@"background.png"];
        
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
        [[NSUserDefaults standardUserDefaults] setInteger:250 forKey:@"scrollSpeed"];
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(screenCenter.x, screenCenter.y);
        [self addChild:apple z:3];
        
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
	}

	return self;
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

- (void)spawnNewObstacle {
    CCNode *previousObstacle = [_branches lastObject];
    CGFloat previousObstacleXPosition = previousObstacle.position.x;
    
    if (!previousObstacle) {
        // this is the first obstacle
        previousObstacleXPosition = firstBranchPosition;
    }
    
    Branch *branch = [CCSprite spriteWithFile:@"balh.png"];
    branch.position = ccp(previousObstacleXPosition + distanceBetweenBranches, 0);
    [branch setupRandomPosition];
    branch.zOrder = DrawingOrderPipes;
    [_branches addObject:branch];
}



//-(void) accelerometer:(UIAccelerometer *)accelerometer
//        didAccelerate:(UIAcceleration *)acceleration
//{
//	// controls how quickly velocity decelerates (lower = quicker to change direction)
//	float deceleration = 0.2f;
//	// determines how sensitive the accelerometer reacts (higher = more sensitive)
//	float sensitivity = 300.0f;
//	// how fast the velocity can be at most
//	float maxVelocity = 500;
//	// adjust velocity based on current accelerometer acceleration
//	float velocityX = apple.velocity.x * deceleration + acceleration.y * sensitivity;
//	// we must limit the maximum velocity of the player sprite, in both directions
//	if (apple.velocity.x > maxVelocity) {
//		velocityX = maxVelocity;
//	}
//	else if (apple.velocity.x < - maxVelocity) {
//		velocityX = - maxVelocity;
//	}
//    
//    apple.velocity = ccp(velocityX, apple.velocity.y);
//}

#pragma mark - Scrolling Backgrounds

-(void) scroll:(ccTime)dt
{
    // moves the bg
    background.position = ccp(screenCenter.x, background.position.y + [[NSUserDefaults standardUserDefaults] integerForKey:@"scrollSpeed"]*dt);
    bg2.position = ccp(screenCenter.x, background.position.y-background.contentSize.height);
    
    // it adds the new bg's to the screen before the old bg's move off the screen
    if (background.position.y >= screenSize.height*1.5)
    {
        background.position = ccp(screenCenter.x, (screenCenter.y)-(background.size.height/2));
    } else if (bg2.position.y >= screenSize.height*1.5) {
        bg2.position = ccp(screenCenter.x, (screenCenter.y)-(bg2.size.height/2));
    }
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
    
}


@end
