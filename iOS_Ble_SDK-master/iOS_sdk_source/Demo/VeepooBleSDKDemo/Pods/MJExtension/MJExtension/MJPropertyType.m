//
//  MJPropertyType.m
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014year Little Code. All rights reserved.
//

#import "MJPropertyType.h"
#import "MJExtension.h"
#import "MJFoundation.h"
#import "MJExtensionConst.h"

@implementation MJPropertyType

+ (instancetype)cachedTypeWithCode:(NSString *)code
{
    MJExtensionAssertParamNotNil2(code, nil);
    
    static NSMutableDictionary *types;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        types = [NSMutableDictionary dictionary];
    });
    
    MJExtensionSemaphoreCreate
    MJExtensionSemaphoreWait
    MJPropertyType *type = types[code];
    if (type == nil) {
        type = [[self alloc] init];
        type.code = code;
        types[code] = type;
    }
    MJExtensionSemaphoreSignal
    return type;
}

#pragma mark - Public method
- (void)setCode:(NSString *)code
{
    _code = code;
    
    MJExtensionAssertParamNotNil(code);
    
    if ([code isEqualToString:MJPropertyTypeId]) {
        _idType = YES;
    } else if (code.length == 0) {
        _KVCDisabled = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // Remove @" and"´╝îIntercept the type name in the middle
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [MJFoundation isClassFromFoundation:_typeClass];
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
        
    } else if ([code isEqualToString:MJPropertyTypeSEL] ||
               [code isEqualToString:MJPropertyTypeIvar] ||
               [code isEqualToString:MJPropertyTypeMethod]) {
        _KVCDisabled = YES;
    }
    
    // Whether it is a number type
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[MJPropertyTypeInt, MJPropertyTypeShort, MJPropertyTypeBOOL1, MJPropertyTypeBOOL2, MJPropertyTypeFloat, MJPropertyTypeDouble, MJPropertyTypeLong, MJPropertyTypeLongLong, MJPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:MJPropertyTypeBOOL1]
            || [lowerCode isEqualToString:MJPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}
@end
