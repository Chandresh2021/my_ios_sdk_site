//
//  MJProperty.m
//  MJExtensionExample
//
//  Created by MJ Lee on 15/4/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJProperty.h"
#import "MJFoundation.h"
#import "MJExtensionConst.h"
#import <objc/message.h>

@interface MJProperty()
@property (strong, nonatomic) NSMutableDictionary *propertyKeysDict;
@property (strong, nonatomic) NSMutableDictionary *objectClassInArrayDict;
@end

@implementation MJProperty

#pragma mark - initialization
- (instancetype)init
{
    if (self = [super init]) {
        _propertyKeysDict = [NSMutableDictionary dictionary];
        _objectClassInArrayDict = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Cache
+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property
{
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    MJProperty *propertyObj = objc_getAssociatedObject(self, property);
    if (propertyObj == nil) {
        propertyObj = [[self alloc] init];
        propertyObj.property = property;
        objc_setAssociatedObject(self, property, propertyObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    MJExtensionSemaphoreSignal
    return propertyObj;
}

#pragma mark - Public method
- (void)setProperty:(objc_property_t)property
{
    _property = property;
    
    MJExtensionAssertParamNotNil(property);
    
    // 1.Attribute name
    _name = @(property_getName(property));
    
    // 2.Member type
    NSString *attrs = @(property_getAttributes(property));
    NSUInteger dotLoc = [attrs rangeOfString:@","].location;
    NSString *code = nil;
    NSUInteger loc = 1;
    if (dotLoc == NSNotFound) { // No,
        code = [attrs substringFromIndex:loc];
    } else {
        code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
    }
    _type = [MJPropertyType cachedTypeWithCode:code];
}

/**
 *  Get the value of a member variable
 */
- (id)valueForObject:(id)object
{
    if (self.type.KVCDisabled) return [NSNull null];
    return [object valueForKey:self.name];
}

/**
 *  Set the value of a member variable
 */
- (void)setValue:(id)value forObject:(id)object
{
    if (self.type.KVCDisabled || value == nil) return;
    [object setValue:value forKey:self.name];
}

/**
 *  Create the corresponding keys through the string key
 */
- (NSArray *)propertyKeysWithStringKey:(NSString *)stringKey
{
    if (stringKey.length == 0) return nil;
    
    NSMutableArray *propertyKeys = [NSMutableArray array];
    // If there are multiple levels of mapping
    NSArray *oldKeys = [stringKey componentsSeparatedByString:@"."];
    
    for (NSString *oldKey in oldKeys) {
        NSUInteger start = [oldKey rangeOfString:@"["].location;
        if (start != NSNotFound) { // Indexed key
            NSString *prefixKey = [oldKey substringToIndex:start];
            NSString *indexKey = prefixKey;
            if (prefixKey.length) {
                MJPropertyKey *propertyKey = [[MJPropertyKey alloc] init];
                propertyKey.name = prefixKey;
                [propertyKeys addObject:propertyKey];
                
                indexKey = [oldKey stringByReplacingOccurrencesOfString:prefixKey withString:@""];
            }
            
            /** Parsing index **/
            // element
            NSArray *cmps = [[indexKey stringByReplacingOccurrencesOfString:@"[" withString:@""] componentsSeparatedByString:@"]"];
            for (NSInteger i = 0; i<cmps.count - 1; i++) {
                MJPropertyKey *subPropertyKey = [[MJPropertyKey alloc] init];
                subPropertyKey.type = MJPropertyKeyTypeArray;
                subPropertyKey.name = cmps[i];
                [propertyKeys addObject:subPropertyKey];
            }
        } else { // Key without index
            MJPropertyKey *propertyKey = [[MJPropertyKey alloc] init];
            propertyKey.name = oldKey;
            [propertyKeys addObject:propertyKey];
        }
    }
    
    return propertyKeys;
}

/** Corresponds to the key in the dictionary */
- (void)setOriginKey:(id)originKey forClass:(Class)c
{
    if ([originKey isKindOfClass:[NSString class]]) { // String type key
        NSArray *propertyKeys = [self propertyKeysWithStringKey:originKey];
        if (propertyKeys.count) {
            [self setPorpertyKeys:@[propertyKeys] forClass:c];
        }
    } else if ([originKey isKindOfClass:[NSArray class]]) {
        NSMutableArray *keyses = [NSMutableArray array];
        for (NSString *stringKey in originKey) {
            NSArray *propertyKeys = [self propertyKeysWithStringKey:stringKey];
            if (propertyKeys.count) {
                [keyses addObject:propertyKeys];
            }
        }
        if (keyses.count) {
            [self setPorpertyKeys:keyses forClass:c];
        }
    }
}

/** Corresponds to the multi-level key in the dictionary */
- (void)setPorpertyKeys:(NSArray *)propertyKeys forClass:(Class)c
{
    if (propertyKeys.count == 0) return;
    NSString *key = NSStringFromClass(c);
    if (!key) return;
    
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    self.propertyKeysDict[key] = propertyKeys;
    MJExtensionSemaphoreSignal
}

- (NSArray *)propertyKeysForClass:(Class)c
{
    NSString *key = NSStringFromClass(c);
    if (!key) return nil;
    return self.propertyKeysDict[key];
}

/** 
Model type in the model array */
- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c
{
    if (!objectClass) return;
    NSString *key = NSStringFromClass(c);
    if (!key) return;
    
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    self.objectClassInArrayDict[key] = objectClass;
    MJExtensionSemaphoreSignal
}

- (Class)objectClassInArrayForClass:(Class)c
{
    NSString *key = NSStringFromClass(c);
    if (!key) return nil;
    return self.objectClassInArrayDict[key];
}
@end
