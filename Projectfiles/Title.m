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
        
        CCSprite *newtonUnderTree = [CCSprite spriteWithFile:@"newtonundertree.png"];
        newtonUnderTree.position = ccp(screenCenter.x,screenCenter.y - (screenCenter.y/5.5));
        [self addChild:newtonUnderTree];
        
    }
    return self;
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
