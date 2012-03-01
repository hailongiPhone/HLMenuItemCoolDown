//
//  HLMenuItemCoolDown.h
//  HLCooldownButtonTest
//
//  Created by HaiLong Guo on 12-2-29.
//  Copyright HaiLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** HLMenuItemCoolDown
 *  
 *  a Cooldown Buttons Inheritance from CCMenuItemImage
 *
 */
@interface HLMenuItemCooldown : CCMenuItemImage 



/** itemFromNormalImage:selectedImage:lastTimeStamp:interval:block
 *
 *  @param  value               普通状态下的图标
 *  @param  value2              点击选中状态下图标
 *  @param  lastTimeStamp       上一次更新时间
 *  @param  interval            cd时间间隔
 *  @param  block               其参数remainingTime 是这这一次CD的剩余时间，
 *                              remainingTime > 0 Cooldown还没有完成
 *
 *  @return HLMenuItemCoolDown 
 */
+(id) itemFromNormalImage:(NSString*)value 
            selectedImage:(NSString*)value2
            lastTimeStamp:(NSDate *)lastTimeStamp
                 interval:(NSTimeInterval)interval
                    block:(void(^)(NSTimeInterval remainingTime))block;
@end
