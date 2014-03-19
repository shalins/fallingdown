//
//  Title.h
//  donthitnewton
//
//  Created by Shalin Shah on 2/14/14.
//
//

#import <Foundation/Foundation.h>

@interface Title : CCLayer <UIAccelerometerDelegate>
{
    // get screen center and screen size
    CGPoint screenCenter;
    CGSize screenSize;
    
    CCMenu *menu;
}

@end
