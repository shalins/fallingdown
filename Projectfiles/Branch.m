//
//  Branch.m
//  donthitnewton
//
//  Created by Vipul Shah on 2/15/14.
//
//

#import "Branch.h"

@implementation Branch {
    CCNode *_leftPipe;
    CCNode *_rightPipe;
}

#define ARC4RANDOM_MAX      0x100000000

// visibility on a 3,5-inch iPhone ends a 88 points and we want some meat
static const CGFloat minimumXPositionLeftBranch = 128.f;
// visibility ends at 480 and we want some meat
static const CGFloat maximumXPositionRightBranch = 440.f;
// distance between top and bottom pipe
static const CGFloat pipeDistance = 142.f;
// calculate the end of the range of top pipe
static const CGFloat maximumYPositionTopPipe = maximumXPositionRightBranch - pipeDistance;

- (void)setupRandomPosition {
    // value between 0.f and 1.f
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat range = maximumYPositionTopPipe - minimumXPositionLeftBranch;
    _leftPipe.position = ccp(_leftPipe.position.x, minimumXPositionLeftBranch + (random * range));
    _rightPipe.position = ccp(_rightPipe.position.x, _leftPipe.position.y + pipeDistance);
}

@end
