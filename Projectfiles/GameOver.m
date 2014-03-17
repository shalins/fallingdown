//
//  GameOver.m
//  donthitnewton
//
//  Created by Shalin Shah on 3/16/14.
//
//

#import "GameOver.h"
#import "Title.h"
#import "HelloWorldLayer.h"

@implementation GameOver
-(id) init
{
	if ((self = [super init]))
	{
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *gameoverbg = [CCSprite spriteWithFile:@"gameover.png"];
        gameoverbg.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:gameoverbg];
        
        CCLabelTTF *restart = [CCLabelTTF labelWithString:@"Restart" fontName:@"Arial" fontSize:40];
        CCLabelTTF *home = [CCLabelTTF labelWithString:@"Home" fontName:@"Arial" fontSize:40];
        
        CCMenuItemLabel *replay = [CCMenuItemLabel itemWithLabel:restart target:self selector:@selector(restart)];
        CCMenuItemLabel *gobackhome = [CCMenuItemLabel itemWithLabel:home target:self selector:@selector(home)];
        
        CCMenu *menu = [CCMenu menuWithItems:replay, gobackhome, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:menu];
        menu.visible = FALSE;
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(screenCenter.x, screenCenter.y*3);
        [self addChild:apple z:4];
        [self appleBounce:apple];
        
    }
    return self;
}

-(void) appleBounce:(CCSprite *) spriteToBeTheNextBigThing {
    id dropdown = [CCMoveTo actionWithDuration:1.8f position:ccp(screenCenter.x, screenCenter.y + 40)];
    id bounceaway = [CCMoveTo actionWithDuration:1.8f position:ccp(screenCenter.x * 2.5, screenCenter.y + 300)];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:dropdown, bounceaway, nil]];
}


-(void) home {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

-(void) restart {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

@end
