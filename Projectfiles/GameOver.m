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
        [self addChild:gameoverbg z:0];
        
        bgtrans = [CCSprite spriteWithFile:@"background1.png"];
        bgtrans.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:bgtrans z:10];
        bgtrans.visible = FALSE;
        
        over = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"04b19" fontSize:50];
        over.position = ccp(screenCenter.x,screenCenter.y * 1.7);
        [self addChild:over z:11];
        over.visible = FALSE;
        
        NSNumber *endingScoreNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedScore"];
        endingScore = [endingScoreNumber intValue];
        NSString *endScoreString = [[NSString alloc] initWithFormat:@"SCORE: %i", endingScore];
        scoreDisplays = [CCLabelTTF labelWithString:endScoreString fontName:@"04b19" fontSize:35];
        scoreDisplays.position = ccp(screenCenter.x, screenCenter.y + 25);
        [self addChild:scoreDisplays z:12];
        scoreDisplays.visible = FALSE;
        
        NSNumber *endingHighScoreNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedHighScore"];
        endingHighScore = [endingHighScoreNumber intValue];
        NSString *endHighScoreString = [[NSString alloc] initWithFormat:@"BEST: %i", endingHighScore];
        highScoreDisplays = [CCLabelTTF labelWithString:endHighScoreString fontName:@"04b19" fontSize:35];
        highScoreDisplays.position = ccp(screenCenter.x, screenCenter.y - 25);
        [self addChild:highScoreDisplays z:12];
        highScoreDisplays.visible = FALSE;
        
        CCMenuItemImage *replay = [CCMenuItemImage itemWithNormalImage:@"restart.png" selectedImage:@"restart-sel.png" target:self selector:@selector(restart)];
        replay.scale = 0.9;
        CCMenuItemImage *gohome = [CCMenuItemImage itemWithNormalImage:@"home.png" selectedImage:@"home-sel.png" target:self selector:@selector(home)];
        gohome.scale = 0.9;
        
        menu = [CCMenu menuWithItems:replay, gohome, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y / 2.85);
        [menu alignItemsVerticallyWithPadding:8];
        [self addChild:menu z:11];
        menu.visible = FALSE;
        
        dispatch_time_t countdown = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(countdown, dispatch_get_main_queue(), ^(void){
            [self fadeEffect:menu];
            [self fadeEffectLabel:over];
            [self fadeEffectLabel:highScoreDisplays];
            [self fadeEffectLabel:scoreDisplays];
            [self fadeEffectSprite:bgtrans];
        });
        
        apple  = [CCSprite spriteWithFile:@"apple.png"];
        apple.position = ccp(-20, screenSize.height+30);
        apple.scale = 1.5;
        [self addChild:apple z:4];
        [self appleBounce:apple];
        
    }
    return self;
}

-(void) appleBounce:(CCSprite *) spriteToBeTheNextBigThing {
    
    // iPhone 5 Optimizations
    if (screenSize.height == 1136) {
        id dropdown = [CCMoveTo actionWithDuration:1.0f position:ccp(screenCenter.x, screenCenter.y)];
    }
    id dropdown = [CCMoveTo actionWithDuration:1.0f position:ccp(screenCenter.x, screenCenter.y + 40)];
    id ease = [CCEaseIn actionWithAction:dropdown rate:1.3];
    id bounceaway = [CCMoveTo actionWithDuration:1.0f position:ccp(screenCenter.x * 2.1, screenSize.height+30)];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:ease, bounceaway, nil]];
}
-(void) home {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[Title node]]];
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
-(void) fadeEffectSprite:(CCSprite *) spriteToBeTheNextBigThing {
    id delay = [CCDelayTime actionWithDuration:1.25];
    id addStuffIn = [CCCallFunc actionWithTarget:self selector:@selector(addStuffIn)];
    id fadeIn = [CCFadeIn actionWithDuration:2.0f];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:delay,addStuffIn,fadeIn, nil]];
}

-(void) fadeEffectLabel:(CCLabelTTF *) spriteToBeTheNextBigThing {
    id delay = [CCDelayTime actionWithDuration:1.25];
    id addStuffIn = [CCCallFunc actionWithTarget:self selector:@selector(addStuffIn)];
    id fadeIn = [CCFadeIn actionWithDuration:2.0f];
    [spriteToBeTheNextBigThing runAction:[CCSequence actions:delay,addStuffIn,fadeIn, nil]];
}

-(void) addStuffIn {
    menu.visible = TRUE;
    over.visible = TRUE;
    bgtrans.visible = TRUE;
    highScoreDisplays.visible = TRUE;
    scoreDisplays.visible = TRUE;
}

@end
