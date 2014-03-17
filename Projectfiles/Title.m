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
        
        CCSprite *newtonUnderTree = [CCSprite spriteWithFile:@"title.png"];
        newtonUnderTree.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:newtonUnderTree];
        
        CCLabelTTF *play = [CCLabelTTF labelWithString:@"Play" fontName:@"Pixelated" fontSize:50];
        
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
