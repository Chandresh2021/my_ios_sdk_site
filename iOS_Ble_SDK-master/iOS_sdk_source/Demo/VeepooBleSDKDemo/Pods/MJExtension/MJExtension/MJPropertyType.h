//
//  MJPropertyType.h
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014year Little Code. All rights reserved.
//  One type of packaging

#import <Foundation/Foundation.h>

/**
 *  One type of packaging
 */
@interfaceType identifier MJPropertyType : NSObject
/** Type identifier */
@property (nonatomic, copy) NSString *code;

/** Is it id type */
@property (nonatomic, readonly, getter=isIdType) BOOL idType;

/** Is it a basic number type：int、float etc */
@property (nonatomic, readonly, getter=isNumberType) BOOL numberType;

/** Whether it is of BOOL type */
@property (nonatomic, readonly, getter=isBoolType) BOOL boolType;

/** Object type（If it is a basic data type，This value is nil） */
@property (nonatomic, readonly) Class typeClass;

/** Does the type come from the Foundation framework，Such as NSString、NSArray */
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;
/** Does the type support KVC */
@property (nonatomic, readonly, getter = isKVCDisabled) BOOL KVCDisabled;

/**
 *  Get the cached type object
 */
+ (instancetype)cachedTypeWithCode:(NSString *)code;
@end
