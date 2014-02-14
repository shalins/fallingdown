/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

-(id) init
{
	if ((self = [super init]))
	{
		glClearColor(0.1f, 0.1f, 0.3f, 1.0f);
        
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];

		// "empty" as in "minimal code & resources"
		//adding background sprites
        background = [CCSprite spriteWithFile:@"tracktest.png"];
        background2 = [CCSprite spriteWithFile:@"tracktest.png"];
        [background.texture setAliasTexParameters];
        [background2.texture setAliasTexParameters];
        
        //position background sprites
        background.position = ccp(background.contentSize.height/2,background.contentSize.width/2);
        background2.position = ccp(screenSize.width,0);
        
        //schedule to move background sprites
        [self schedule:@selector(scroll:)];
        
        //adding them to the main layer
        [self addChild:background z:0];
        [self addChild:background2 z:0];
        [self scheduleUpdate];
	}

	return self;
}

-(void) update:(ccTime)delta
{
}

-(void) scroll:(ccTime)dt
{
    //move 30*dt px vertically
    if (background.position.x<background2.position.x){
        background.position = ccp(background.position.x - 30*dt,background.contentSize.height/2);
        background2.position = ccp(background.position.x+background.contentSize.width,background2.contentSize.height/2);
    }else{
        background2.position = ccp(background2.position.x- 30*dt,background2.contentSize.height/2);
        background.position = ccp(background2.position.x+background2.contentSize.width ,background.contentSize.height/2);
        
    }
    
    //reset offscreen position
    if (background.position.x <-background.contentSize.width/2)
    {
        background.position = ccp(background2.position.x+background2.contentSize.width,background.contentSize.width/2);
    }else if (background2.position.x < -background2.contentSize.width/2)
    {
        background2.position = ccp(background.position.x+background.contentSize.width, background2.contentSize.width/2);
    }
}

@end
