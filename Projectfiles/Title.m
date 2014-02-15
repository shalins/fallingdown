//
//  Title.m
//  donthitnewton
//
//  Created by Shalin Shah on 2/14/14.
//
//

#import "Title.h"

@implementation Title

-(id) init
{
	if ((self = [super init]))
	{
        // get screen center and screen size
        screenCenter = [CCDirector sharedDirector].screenCenter;
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *newtonUnderTree = [CCSprite spriteWithFile:@"newtonundertree.png"];
        newtonUnderTree.position = ccp(screenCenter.x,screenCenter.y);
        [self addChild:newtonUnderTree];
    }
    return self;
}




@end
