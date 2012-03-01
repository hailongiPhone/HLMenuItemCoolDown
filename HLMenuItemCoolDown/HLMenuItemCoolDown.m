//
//  HLMenuItemCoolDown.m
//  HLCooldownButtonTest
//
//  Created by HaiLong Guo on 12-2-29.
//  Copyright HaiLong. All rights reserved.
//

#import "HLMenuItemCoolDown.h"

#define kProgressPrecision      0.001

@interface HLMenuItemCoolDown ()
@property (nonatomic, retain) NSDate * lastTimeStamp;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, retain) NSString * normalName;
@property (nonatomic, copy) void (^blockHL)(NSTimeInterval intervalLeft);
@property (nonatomic, assign) CCProgressTimer * pro;

- (void)addProgress;
- (void)updatePro;
- (float)progressPercentage;
- (NSTimeInterval)remainingTime;
@end

@implementation HLMenuItemCoolDown
@synthesize lastTimeStamp = _lastTimeStamp;
@synthesize interval = _interval;
@synthesize blockHL = _blockHL;
@synthesize normalName = _normalName;
@synthesize pro = _pro;

- (void)dealloc
{
    self.lastTimeStamp = nil;
    self.normalName = nil;
    [super dealloc];
}

+(id) itemFromNormalImage:(NSString*)value 
            selectedImage:(NSString*) value2
            lastTimeStamp:(NSDate *)lastTimeStamp
                 interval:(NSTimeInterval)interval
                    block:(void(^)(NSTimeInterval remainingTime))block
{
    HLMenuItemCoolDown * tmp = [self itemFromNormalImage:value selectedImage:value2 disabledImage:nil block:^(id sender) {
        HLMenuItemCoolDown * tmp = sender;    
        NSTimeInterval remaining = [tmp remainingTime];
        if (remaining < kProgressPrecision) {
            tmp.lastTimeStamp = [NSDate date];
            [tmp updatePro];
            remaining = 0;
        }
        tmp.blockHL(remaining);
    }];
    if (!lastTimeStamp) {
        lastTimeStamp = [NSDate date];
    }
    tmp.lastTimeStamp = lastTimeStamp;
    tmp.interval = interval;
    tmp.blockHL = block;
    tmp.normalName = value;
    return tmp;
}

#pragma mark - override & add CCProgressTimer 

-(id) initFromNormalSprite:(CCNode<CCRGBAProtocol>*)normalSprite selectedSprite:(CCNode<CCRGBAProtocol>*)selectedSprite disabledSprite:(CCNode<CCRGBAProtocol>*)disabledSprite target:(id)target selector:(SEL)selector
{
	if( (self=[super initWithTarget:target selector:selector]) ) {
		self.normalImage = normalSprite;
		self.selectedImage = selectedSprite;
		self.disabledImage = disabledSprite;
		[self setContentSize: [normalImage_ contentSize]];
        
        [self schedule:@selector(addProgress)];
	}
	return self;	
}

- (void)addProgress
{
    
    CCTexture2D * tmp = [[CCTextureCache sharedTextureCache] textureForKey:self.normalName];
    if (!tmp) {
        return;
    }
    [self unschedule:_cmd];
    
    
    _pro = [CCProgressTimer progressWithTexture:tmp];
    _pro.type = kCCProgressTimerTypeRadialCW;
    _pro.percentage = 100;
    _pro.position = ccp(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
    [self addChild:_pro];
    
    [self updatePro];
}

- (void)updatePro
{
    _pro.percentage = [self progressPercentage];
    NSTimeInterval thisInterval = [self remainingTime];
    if (thisInterval > kProgressPrecision) {
        self.color = ccGRAY;
        [_pro runAction:[CCProgressTo actionWithDuration:thisInterval percent:100]];
    }
}

- (NSTimeInterval)remainingTime
{
    NSTimeInterval last = ABS([_lastTimeStamp timeIntervalSinceNow]);
    return MAX(_interval - last,0);//(1 - preCentage) * _interval;
}

- (float)progressPercentage
{
    NSTimeInterval last = ABS([_lastTimeStamp timeIntervalSinceNow]);
    float percentage = 100;
    if (last<_interval) {
        NSTimeInterval preCentage = last/_interval;
        percentage = 100* preCentage;
    }
    return percentage;
}
@end
