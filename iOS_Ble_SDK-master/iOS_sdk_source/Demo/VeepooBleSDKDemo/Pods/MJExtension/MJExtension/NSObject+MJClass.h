//
//  NSObject+MJClass.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/8/11.
//  Copyright (c) 2015year Little Code. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Traverse all types of blocks（father）
 */
typedef void (^MJClassesEnumeration)(Class c, BOOL *stop);

/** The attribute names in this array will be converted from dictionary to model */
typedef NSArray * (^MJAllowedPropertyNames)(void);
/** The attribute names in this array will be archived */
typedef NSArray * (^MJAllowedCodingPropertyNames)(void);

/** Property names in this array will be ignored：No dictionary and model conversion */
typedef NSArray * (^MJIgnoredPropertyNames)(void);
/** Property names in this array will be ignored：Do not archive */
typedef NSArray * (^MJIgnoredCodingPropertyNames)(void);

/**
 * Class-related extensions
 */
@interface NSObject (MJClass)
/**
 *  Traverse all classes
 */
+ (void)mj_enumerateClasses:(MJClassesEnumeration)enumeration;
+ (void)mj_enumerateAllClasses:(MJClassesEnumeration)enumeration;

#pragma mark - Attribute whitelist configuration
/**
 *  The attribute names in this array will be converted from dictionary to model
 *
 *  @param allowedPropertyNames          The attribute names in this array will be converted from dictionary to model
 */
+ (void)mj_setupAllowedPropertyNames:(MJAllowedPropertyNames)allowedPropertyNames;

/**
 *  The attribute names in this array will be converted from dictionary to model
 */
+ (NSMutableArray *)mj_totalAllowedPropertyNames;

#pragma mark - Property blacklist configuration
/**
 *  Property names in this array will be ignored：No dictionary and model conversion
 *
 *  @param ignoredPropertyNames          Property names in this array will be ignored：No dictionary and model conversion
 */
+ (void)mj_setupIgnoredPropertyNames:(MJIgnoredPropertyNames)ignoredPropertyNames;

/**
 *  Property names in this array will be ignored：No dictionary and model conversion
 */
+ (NSMutableArray *)mj_totalIgnoredPropertyNames;

#pragma mark - Archive attribute whitelist configuration
/**
 *  The attribute names in this array will be archived
 *
 *  @param allowedCodingPropertyNames          The attribute names in this array will be archived
 */
+ (void)mj_setupAllowedCodingPropertyNames:(MJAllowedCodingPropertyNames)allowedCodingPropertyNames;

/**
 *  The attribute names in this array will be converted from dictionary to model
 */
+ (NSMutableArray *)mj_totalAllowedCodingPropertyNames;

#pragma mark - Archive attribute blacklist configuration
/**
 *  Property names in this array will be ignored：Do not archive
 *
 *  @param ignoredCodingPropertyNames          
* Property names in this array will be ignored：Do not archive
 */
+ (void)mj_setupIgnoredCodingPropertyNames:(MJIgnoredCodingPropertyNames)ignoredCodingPropertyNames;

/**
 *  
Property names in this array will be ignored：Do not archive
 */
+ (NSMutableArray *)mj_totalIgnoredCodingPropertyNames;

#pragma mark - internal use
+ (void)mj_setupBlockReturnValue:(id (^)(void))block key:(const char *)key;
@end
