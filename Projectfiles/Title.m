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
        
        CCMenuItemImage *play = [CCMenuItemImage itemWithNormalImage:@"play.png" selectedImage:@"play-sel.png" target:self selector:@selector(start)];
        play.scale = 0.8;
        
        menu = [CCMenu menuWithItems:play, nil];
        menu.position = ccp(screenCenter.x,screenCenter.y / 2);
        [menu alignItemsVerticallyWithPadding:6];
        [self addChild:menu];
        menu.visible = FALSE;

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
