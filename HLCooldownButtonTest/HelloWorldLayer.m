//
//  HelloWorldLayer.m
//  HLCooldownButtonTest
//
//  Created by HaiLong Guo on 12-2-29.
//  Copyright HaiLong. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "HLMenuItemCooldown.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
        
//      How it works?  Two Layer
  
        //The background: a Sprite
		CCSprite * spTmp = [CCSprite spriteWithFile:@"cd.png"];
        spTmp.color = ccGRAY;               // key point
        
        //The foreground: a CCProgressTimer
        CCProgressTimer * pro = [CCProgressTimer progressWithFile:@"cd.png"];
        pro.type = kCCProgressTimerTypeRadialCW;
        pro.percentage = 100;
        pro.position = ccp(50, 160);
        spTmp.position = ccp(50, 160);
        [self addChild:spTmp];
        [self addChild: pro];
        
        [pro runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCProgressFromTo actionWithDuration:3 from:0 to:100], [CCDelayTime actionWithDuration:0.5],nil]]];
        
//      Encapsulation this To a MenuItem
        HLMenuItemCooldown * coolDown = [HLMenuItemCooldown itemFromNormalImage:@"Icon.png" selectedImage:@"Icon.png" lastTimeStamp:nil interval:2 block:^(NSTimeInterval remainingTime) {
             NSLog(@"coolDownItem = %f",remainingTime);
        }];
        coolDown.position = ccp(240, 250);
        
        
        HLMenuItemCooldown * coolDown2 = [HLMenuItemCooldown itemFromNormalImage:@"cd.png" selectedImage:@"cd.png" lastTimeStamp:[NSDate dateWithTimeIntervalSinceNow:-5] interval:20 block:^(NSTimeInterval remainingTime) {
            NSLog(@"coolDownItem = %f",remainingTime);
        }];
        coolDown2.position = ccp(240, 140);
        
        CCMenu * menu = [CCMenu menuWithItems:coolDown,coolDown2, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
