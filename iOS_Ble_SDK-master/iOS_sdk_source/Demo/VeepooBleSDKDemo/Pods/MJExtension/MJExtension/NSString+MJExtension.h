//
//  NSString+MJExtension.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015year Little Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtensionConst.h"

@interface NSString (MJExtension)
/**
 *  Hump ​​to underline（loveYou -> love_you）
 */
- (NSString *)mj_underlineFromCamel;
/**
 *  Underscore to hump（love_you -> loveYou）
 */
- (NSString *)mj_camelFromUnderline;
/**
 * Capitalize the first letter
 */
- (NSString *)mj_firstCharUpper;
/**
 * Lowercase first letter
 */
- (NSString *)mj_firstCharLower;

- (BOOL)mj_isPureInt;

- (NSURL *)mj_url;
@end

@interface NSString (MJExtensionDeprecated_v_2_5_16)
- (NSString *)underlineFromCamel MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
- (NSString *)camelFromUnderline MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
- (NSString *)firstCharUpper MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
- (NSString *)firstCharLower MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
- (BOOL)isPureInt MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
- (NSURL *)url MJExtensionDeprecated("Please prefix the method name with mj_，Use mj_***");
@end
