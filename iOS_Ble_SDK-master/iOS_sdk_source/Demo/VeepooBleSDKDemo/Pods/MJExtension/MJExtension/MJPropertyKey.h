//
//  MJPropertyKey.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/8/11.
//  Copyright (c) 2015year Little Code. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MJPropertyKeyTypeDictionary = 0, // Dictionary key
    MJPropertyKeyTypeArray // Array key
} MJPropertyKeyType;

/**
 *  Attribute key
 */
@interface MJPropertyKey : NSObject
/** key的名字 */
@property (copy,   nonatomic) NSString *name;
/** Type of key，maybe@"10"，maybe@"age" */
@property (assign, nonatomic) MJPropertyKeyType type;

/**
 *  According to the current key，Which is name，从object（Dictionary or array）Medium value
 */
- (id)valueInObject:(id)object;

@end
