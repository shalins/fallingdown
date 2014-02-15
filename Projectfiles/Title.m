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
        
        
        
    }
    return self;
}




@end
