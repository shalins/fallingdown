//
//  Apple.h
//  donthitnewton
//
//  Created by Shalin Shah on 2/15/14.
//
//

#import "CCSprite.h"

@interface Apple : CCSprite
{
    
}

// velocity in pixels per second
@property (nonatomic, assign) CGPoint velocity;

// defines a hit zone, which is smaller as the sprite, only if this hit zone is hit the knight is injured
@property (nonatomic, assign) CGRect hitZone;


@end
