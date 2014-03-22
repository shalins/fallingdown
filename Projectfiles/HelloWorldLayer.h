/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "kobold2d.h"
#import "Apple.h"
//#import "Branch.h"

@interface HelloWorldLayer : CCLayer
{
    // get screen center and screen size
    CGPoint screenCenter;
    CGSize screenSize;
    
    // backgrounds
    CCSprite *background;
    CCSprite *bg2;
        
    int score;
    int targetScore;
    int scoreAdded;
    
    NSString *scoreCounter;
    CCLabelTTF *scoreDisplay;
    
    int *scrollSpeed;
    
    Apple *apple;
    
    BOOL appleRight;
    BOOL appleLeft;
    
    CCSprite *branch;
    NSMutableArray *_branches;
    CCSprite *obstacle;
    CCNode *previousBranch;
    CGFloat previousBranchYPosition;
    NSMutableArray *pipes;
    
    CGPoint posTouchScreen;
    CGPoint coord;
    CGPoint playerpos;


}

@property (nonatomic, assign) CGPoint velocity;

@end
