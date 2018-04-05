//
//  JSON.h
//  ObjcJSON
//
//  Created by Pham  on 3/4/18.
//  Copyright © 2018 Pham Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON : NSObject

- (id _Nonnull) initWithJsonObject:(id _Nullable)object;

- (NSNumber * _Nullable) number;
- (NSString * _Nullable) string;
- (NSArray<JSON*> * _Nullable) array;
- (NSDictionary<NSString*, JSON*> * _Nullable) dict;
- (NSArray<id> * _Nullable) arrayValue;
- (NSDictionary<NSString*, id> * _Nullable) dictValue;
- (int) intValue;
- (float) floatValue;
- (double) doubleValue;
- (BOOL) boolValue;

#pragma mark - Subscripting
- (JSON * _Nullable ) objectAtIndexedSubscript:(int)idx;
- (JSON * _Nullable ) objectForKeyedSubscript:(NSString * _Nonnull)key;

@end
