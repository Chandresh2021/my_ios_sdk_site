
#ifndef __MJExtensionConst__H__
#define __MJExtensionConst__H__

#import <Foundation/Foundation.h>

// signal
#define MJExtensionSemaphoreCreate \
static dispatch_semaphore_t signalSemaphore; \
static dispatch_once_t onceTokenSemaphore; \
dispatch_once(&onceTokenSemaphore, ^{ \
    signalSemaphore = dispatch_semaphore_create(1); \
});

#define MJExtensionSemaphoreWait \
dispatch_semaphore_wait(signalSemaphore, DISPATCH_TIME_FOREVER);

#define MJExtensionSemaphoreSignal \
dispatch_semaphore_signal(signalSemaphore);

// Expired
#define MJExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// Build error
#define MJExtensionBuildError(clazz, msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \
[clazz setMj_error:error];

// Build error
#ifdef DEBUG
#define MJExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define MJExtensionLog(...)
#endif

/**
 * assertion
 * @param condition   condition
 * @param returnValue return value
 */
#define MJExtensionAssertError(condition, returnValue, clazz, msg) \
[clazz setMj_error:nil]; \
if ((condition) == NO) { \
    MJExtensionBuildError(clazz, msg); \
    return returnValue;\
}

#define MJExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * assertion
 * @param condition   condition
 */
#define MJExtensionAssert(condition) MJExtensionAssert2(condition, )

/**
 * assertion
 * @param param         parameter
 * @param returnValue   return value
 */
#define MJExtensionAssertParamNotNil2(param, returnValue) \
MJExtensionAssert2((param) != nil, returnValue)

/**
 * 
assertion
 * @param param   parameter
 */
#define MJExtensionAssertParamNotNil(param) MJExtensionAssertParamNotNil2(param, )

/**
 * Print all attributes
 */
#define MJLogAllIvars \
-(NSString *)description \
{ \
    return [self mj_keyValues].description; \
}
#define MJExtensionLogAllProperties MJLogAllIvars

/**
 *  
Types of（Attribute type）
 */
extern NSString *const MJPropertyTypeInt;
extern NSString *const MJPropertyTypeShort;
extern NSString *const MJPropertyTypeFloat;
extern NSString *const MJPropertyTypeDouble;
extern NSString *const MJPropertyTypeLong;
extern NSString *const MJPropertyTypeLongLong;
extern NSString *const MJPropertyTypeChar;
extern NSString *const MJPropertyTypeBOOL1;
extern NSString *const MJPropertyTypeBOOL2;
extern NSString *const MJPropertyTypePointer;

extern NSString *const MJPropertyTypeIvar;
extern NSString *const MJPropertyTypeMethod;
extern NSString *const MJPropertyTypeBlock;
extern NSString *const MJPropertyTypeClass;
extern NSString *const MJPropertyTypeSEL;
extern NSString *const MJPropertyTypeId;

#endif
