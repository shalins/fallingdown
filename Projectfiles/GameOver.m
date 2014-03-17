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
        
        menu = [CCMenu menuWithItems:replay, gobackhome, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y);
        [menu alignItemsVerticallyWithPadding:4];
        [self addChild:menu];
        menu.visible = FALSE;
        
        dispatch_time_t countdown = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(countdown, dispatch_get_main_queue(), ^(void){
            [self fadeEffect:menu];
        });
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(screenCenter.x, screenCenter.y*3);
        apple.scale = 1.5;
        [self addChild:apple z:4];
        [self appleBounce:apple];
        
    }
    return self;
}

-(void) appleBounce:(CCSprite *) spriteToBeTheNextBigThing {
    id dropdown = [CCMoveTo actionWithDuration:1.0f position:ccp(screenCenter.x, screenCenter.y + 40)];
    id bounceaway = [CCMoveTo actionWithDuration:1.0f position:ccp(screenCenter.x * 2.5, screenCenter.y + 200)];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:dropdown, bounceaway, nil]];
}


-(void) home {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

-(void) restart {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}
-(void) fadeEffect:(CCMenu *) spriteToBeTheNextBigThing {
    id delay = [CCDelayTime actionWithDuration:1.25];
    id addStuffIn = [CCCallFunc actionWithTarget:self selector:@selector(addStuffIn)];
    id fadeIn = [CCFadeIn actionWithDuration:2.0f];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:delay,addStuffIn,fadeIn, nil]];
}
-(void) addStuffIn {
    menu.visible = TRUE;
}

@end
