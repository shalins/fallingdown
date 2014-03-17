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
        
        CCSprite *newtonUnderTree = [CCSprite spriteWithFile:@"title.png"];
        newtonUnderTree.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:newtonUnderTree];
        
        CCLabelTTF *play = [CCLabelTTF labelWithString:@"Play" fontName:@"Arial" fontSize:21];
        
        CCMenuItemLabel *startGame = [CCMenuItemLabel itemWithLabel:play target:self selector:@selector(start)];
        
        CCMenu *menu = [CCMenu menuWithItems:startGame, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y / 2);
        [self addChild:menu];
        
    }
    return self;
}

-(void) start {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

@end
