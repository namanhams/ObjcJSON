//
//  JSON.m
//  ObjcJSON
//
//  Created by Pham  on 3/4/18.
//  Copyright © 2018 Pham Le. All rights reserved.
//

#import "JSON.h"

@interface JSON ()
@property (nonatomic, strong) id rootObject;
@end

@implementation JSON

- (id _Nonnull) initWithJsonObject:(id _Nullable)object {
    self = [super init];
    self.rootObject = object;
//    if(object == nil
//       || [object isKindOfClass:[NSDictionary class]]
//       || [object isKindOfClass:[NSArray class]]
//       || [object isKindOfClass:[NSString class]]
//       || [object isKindOfClass:[NSNumber class]]
//       || [object isKindOfClass:[NSNull class]])
//    {
//        return self;
//    }
//    return nil;
    
    return self;
}

- (NSNumber * _Nullable) number {
    if([self.rootObject isKindOfClass:[NSNumber class]])
        return (NSNumber *) self.rootObject;
    return nil;
}

- (NSString * _Nullable) string {
    if([self.rootObject isKindOfClass:[NSString class]])
        return (NSString *) self.rootObject;
    return nil;
}

- (NSArray<JSON*> * _Nullable) array {
    if(! [self.rootObject isKindOfClass:[NSArray class]])
        return nil;
    
    NSMutableArray *res = [NSMutableArray array];
    for(int i = 0; i < [self.rootObject count]; i++)
        [res addObject:[[JSON alloc] initWithJsonObject:self.rootObject[i]]];
    
    return [NSArray arrayWithArray:res];
}

- (NSDictionary<NSString*, JSON*> * _Nullable) dict {
    if(! [self.rootObject isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSMutableDictionary *res = [NSMutableDictionary dictionary];
    for(NSString *key in [self.rootObject allKeys])
        res[key] = [[JSON alloc] initWithJsonObject:self.rootObject[key]];
    
    return [NSDictionary dictionaryWithDictionary:res];
}

- (NSArray<id> * _Nullable) arrayValue {
    if([self.rootObject isKindOfClass:[NSArray class]])
        return (NSArray *) self.rootObject;
    return nil;
}

- (NSDictionary<NSString*, id> * _Nullable) dictValue {
    if([self.rootObject isKindOfClass:[NSDictionary class]])
        return (NSDictionary *) self.rootObject;
    return nil;
}

- (int) intValue {
    return [self.number intValue];
}

- (float) floatValue {
    return [self.number floatValue];
}

- (double) doubleValue {
    return [self.number doubleValue];
}

- (BOOL) boolValue {
    return [self.number boolValue];
}

#pragma mark - Subscripting

- (id)objectAtIndexedSubscript:(int)idx {
    NSArray *array = self.array;
    if(idx < array.count)
        return array[idx];
    return nil;
}

- (void)setObject:(id)obj atIndexedSubscript:(int)idx {
    // NSAssert(false, @"Not implemented");
}

- (id)objectForKeyedSubscript:(NSString *)key {
    NSDictionary *dict = self.dict;
    return dict[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
    // NSAssert(false, @"Not implemented");
}

@end
