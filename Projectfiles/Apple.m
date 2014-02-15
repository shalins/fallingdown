//
//  Apple.m
//  donthitnewton
//
//  Created by Vipul Shah on 2/15/14.
//
//

#import "Apple.h"
#import "HelloWorldLayer.h"

@implementation Apple

- (void)dealloc
{
    /*
     When our object is removed, we need to unregister from all notifications.
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithApplePicture {
    self = [super initWithFile:@"apple.png"];
    
	if ((self = [super init]))
    {
        
    
    }
    return self;
}


- (void)updateRunningMode:(ccTime)delta
{
    // flip the animation when moving backwards
    //    if (self.velocity.x < -50.f)
    //    {
    //        self.flipX = TRUE;
    //    }
    //    else if (self.velocity.x > 50.f)
    //    {
    //        self.flipX = FALSE;
    //    }
    
    // apply gravity
    CGPoint gravity = CGPointZero;
    float xVelocity = self.velocity.x;
    float yVelocity = self.velocity.y;
    
    NSAssert(gravity.x <= 0, @"Currently only negative gravity is supported");
    // only apply gravity if the current velocity is not equal to the gravity velocity
    if (xVelocity > gravity.x)
    {
        xVelocity = self.velocity.x + (gravity.x * delta);
    }
    
    NSAssert(gravity.y <= 0, @"Currently only negative gravity is supported");
    // only apply gravity if the current velocity is not equal to the gravity velocity
    if (yVelocity > gravity.y)
    {
        yVelocity = self.velocity.y + (gravity.y * delta);
    }
    
    self.velocity = ccp(xVelocity, yVelocity);
    
    [self setPosition:ccpAdd(self.position, ccpMult(self.velocity,delta))];
    
    // check that knight does not leave left screen border
    if (self.position.x < 0)
    {
        self.position = ccp(0, self.position.y);
    }
    
    // check that knight does not leave right screen border
    CGSize sceneSize = [[CCDirector sharedDirector] winSize];
    int rightBorder = sceneSize.width - self.contentSize.width;
    if (self.position.x > rightBorder) {
        self.position = ccp(rightBorder, self.position.y);
    }
    
    // calculate a hit zone
    CGPoint appleCenter = ccp(self.position.x + self.contentSize.width / 2, self.position.y + self.contentSize.height / 2);
    CGSize hitZoneSize = CGSizeMake(self.contentSize.width/2, self.contentSize.height/2);
    self.hitZone = CGRectMake(appleCenter.x - 0.5 * hitZoneSize.width, appleCenter.y - 0.5 * hitZoneSize.width, hitZoneSize.width, hitZoneSize.height);
}


@end
