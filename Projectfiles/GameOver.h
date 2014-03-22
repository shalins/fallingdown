//
//  GameOver.h
//  donthitnewton
//
//  Created by Shalin Shah on 3/16/14.
//
//

#import "CCScene.h"
#import "Apple.h"

@interface GameOver : CCLayer
{
    // get screen center and screen size
    CGPoint screenCenter;
    CGSize screenSize;
    CCMenu *menu;
    CCMenu *menu2;
    CCMenu *menu3;
    CCMenu *menu4;
    CCMenu *menu5;
    CCLabelTTF *over;
    Apple *apple;
}
@end
