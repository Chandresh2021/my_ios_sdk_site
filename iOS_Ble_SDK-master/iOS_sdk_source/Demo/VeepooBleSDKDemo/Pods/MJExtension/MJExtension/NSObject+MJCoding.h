//
//  NSObject+MJCoding.h
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014year Little Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtensionConst.h"

/**
 *  Codeing协议
 */
@protocol MJCoding <NSObject>
@optional
/**
 *  The attribute names in this array will be archived
 */
+ (NSArray *)mj_allowedCodingPropertyNames;
/**
 *  Property names in this array will be ignored：Do not archive
 */
+ (NSArray *)mj_ignoredCodingPropertyNames;
@end

@interface NSObject (MJCoding) <MJCoding>
/**
 *  decoding（Parse the object from the file）
 */
- (void)mj_decode:(NSCoder *)decoder;
/**
 *  coding（Write object to file）
 */
- (void)mj_encode:(NSCoder *)encoder;
@end

/**
 Archiving realization
 */
#define MJCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self mj_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self mj_encode:encoder]; \
}

#define MJExtensionCodingImplementation MJCodingImplementation
