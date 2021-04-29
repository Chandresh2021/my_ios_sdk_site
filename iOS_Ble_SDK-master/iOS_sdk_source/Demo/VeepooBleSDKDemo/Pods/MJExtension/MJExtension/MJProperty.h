//
//  MJProperty.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/4/17.
//  Copyright (c) 2015year Little Code. All rights reserved.
//  Wrap a member attribute

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MJPropertyType.h"
#import "MJPropertyKey.h"

/**
 *  Pack a member
 */
@interface MJProperty : NSObject
/** Member attributes */
@property (nonatomic, assign) objc_property_t property;
/** The name of the member attribute */
@property (nonatomic, readonly) NSString *name;

/** Member attribute type */
@property (nonatomic, readonly) MJPropertyType *type;
/** Which class the member attribute comes from（May be the parent class） */
@property (nonatomic, assign) Class srcClass;

/**** Same member attribute - The behavior of parent and child may be inconsistent（originKey、propertyKeys、objectClassInArray） ****/
/** Set the most original key */
- (void)setOriginKey:(id)originKey forClass:(Class)c;
/** Corresponds to the multi-level key in the dictionary（The array stored inside，There are all MJPropertyKey objects in the array） */
- (NSArray *)propertyKeysForClass:(Class)c;

/** Model type in the model array */
- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c;
- (Class)objectClassInArrayForClass:(Class)c;
/**** The same member variable - The behavior of parent and child may be inconsistent（key、keys、objectClassInArray） ****/

/**
 * Set the value of the member variable of the object
 */
- (void)setValue:(id)value forObject:(id)object;
/**
 * 
Get the member attribute value of object
 */
- (id)valueForObject:(id)object;

/**
 *  initialization
 */
+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property;

@end
