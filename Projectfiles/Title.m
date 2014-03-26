//
//  Title.m
//  donthitnewton
//
//  Created by Shalin Shah on 2/14/14.
//
//

#import "Title.h"
#import "HelloWorldLayer.h"

@implementation Title

-(id) init
{
	if ((self = [super init]))
	{
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];
        
        over = [CCLabelTTF labelWithString:@"DONT HIT \n NEWTON" fontName:@"04b19" fontSize:65];
        over.position = ccp(screenCenter.x,screenCenter.y * 1.6);
        [self addChild:over z:3];
        
        CCSprite *bgtrans = [CCSprite spriteWithFile:@"background1.png"];
        bgtrans.position = ccp(screenCenter.x,screenCenter.y);
//        [self addChild:bgtrans z:1];
        
        CCSprite *newtonUnderTree = [CCSprite spriteWithFile:@"title.png"];
        newtonUnderTree.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:newtonUnderTree z:0];
        
        CCMenuItemImage *play = [CCMenuItemImage itemWithNormalImage:@"play.png" selectedImage:@"play-sel.png" target:self selector:@selector(start)];
        play.scale = 1;
        
        CCLabelTTF *plasas = [CCLabelTTF labelWithString:@"PLAY" fontName:@"04b19" fontSize:40];
        CCMenuItemLabel *played = [CCMenuItemLabel itemWithLabel:plasas target:self selector:@selector(start)];
        played.scale = 1;

        
        menu = [CCMenu menuWithItems:played, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y / 2);
        [menu alignItemsVerticallyWithPadding:6];
        [self addChild:menu z:3];
        
        

    }
    return self;
}

-(void) start {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    
//    if (motion == UIEventSubtypeMotionShake)
//    {
//        // Handle shake event here...
//        [[CCDirector sharedDirector] replaceScene:
//         [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
//    }
//}




//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if(event.type == UIEventSubtypeMotionShake)
//    {
//    }
//}

@end
