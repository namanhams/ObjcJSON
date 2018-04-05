//
//  ObjcJSONTests.m
//  ObjcJSONTests
//
//  Created by Pham  on 3/4/18.
//  Copyright © 2018 Pham Le. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSON.h"

@interface ObjcJSONTests : XCTestCase

@end

@implementation ObjcJSONTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testInit {
    XCTAssert([[JSON alloc] initWithJsonObject:nil]);
    XCTAssert([[JSON alloc] initWithJsonObject:[NSDate date]]);
    XCTAssert([[JSON alloc] initWithJsonObject:@(1)]);
    
    NSArray *a = @[@"a", @"b", @(1)];
    XCTAssert([[JSON alloc] initWithJsonObject:a]);
    
    NSDictionary *dict = @{@"a":@(1), @"b":@(2)};
    XCTAssert([[JSON alloc] initWithJsonObject:dict]);
}

- (void) testPrimitiveAccessors {
    JSON *json = nil;
    
    json = [[JSON alloc] initWithJsonObject:@(10)];
    [self assertJSON:json isPrimitiveValue:@(10)];
    
    json = [[JSON alloc] initWithJsonObject:@(true)];
    [self assertJSON:json isPrimitiveValue:@(true)];
}

- (void) testArray {
    NSArray *a = @[@(1), @"a"];
    
    JSON *json = [[JSON alloc] initWithJsonObject:a];
    
    // arrayValue
    XCTAssertEqual(json.arrayValue, a);
    
    // array
    XCTAssertEqual(json.array.count, 2);
    [self assertJSON:json.array[0] isPrimitiveValue:@(1)];
    [self assertJSON:json.array[1] isString:@"a"];
    
    // Everything else is nil
    XCTAssertNil(json.dict);
    XCTAssertNil(json.dictValue);
    XCTAssertNil(json.string);
    XCTAssertNil(json.number);
}

- (void) testDict {
    NSDictionary *dict = @{@"a": @(1), @"b": @"X"};
    
    JSON *json = [[JSON alloc] initWithJsonObject:dict];
    
    // dictValue
    XCTAssertEqual(json.dictValue, dict);
    
    // dict
    XCTAssertEqual(json.dict.count, 2);
    [self assertJSON:json.dict[@"a"] isPrimitiveValue:@(1)];
    [self assertJSON:json.dict[@"b"] isString:@"X"];
    
    // Everything else is nil
    XCTAssertNil(json.array);
    XCTAssertNil(json.arrayValue);
    XCTAssertNil(json.string);
    XCTAssertNil(json.number);
}

- (void) testSubscript {
    JSON *json = nil;
    
    json = [[JSON alloc] initWithJsonObject:@(1)];
    XCTAssertNil(json[0]);
    XCTAssertNil(json[1]);
    XCTAssertNil(json[@"1"]);
    XCTAssertNil(json[@""]);
    
    json = [[JSON alloc] initWithJsonObject:@"a"];
    XCTAssertNil(json[0]);
    XCTAssertNil(json[-1]);
    XCTAssertNil(json[@"1"]);
    XCTAssertNil(json[@""]);
    
    json = [[JSON alloc] initWithJsonObject:@[@(1), @"a", @[@(2), @"b"]]];
    [self assertJSON:json[0] isPrimitiveValue:@(1)];
    [self assertJSON:json[1] isString:@"a"];
    [self assertJSON:json[2][0] isPrimitiveValue:@(2)];
    [self assertJSON:json[2][1] isString:@"b"];
    XCTAssertEqual(json[0].number, @(1));
    XCTAssertEqual(json[1].string, @"a");
    XCTAssertNil(json[3]);
    XCTAssertNil(json[@"a"]);
    
    json = [[JSON alloc] initWithJsonObject:@{@"a": @(1), @"b" : @"X", @"c" : @[@(3), @"d"]}];
    [self assertJSON:json[@"a"] isPrimitiveValue:@(1)];
    [self assertJSON:json[@"b"] isString:@"X"];
    [self assertJSON:json[@"c"][0] isPrimitiveValue:@(3)];
    [self assertJSON:json[@"c"][1] isString:@"d"];
    XCTAssertNil(json[@"d"]);
    XCTAssertNil(json[0]);
    XCTAssertNil(json[1]);
}

- (void) assertJSON:(JSON *)json isString:(NSString *)value {
    XCTAssertEqualObjects(json.string, value);
    
    XCTAssertNil(json.number);
    XCTAssertNil(json.array);
    XCTAssertNil(json.arrayValue);
    XCTAssertNil(json.dict);
    XCTAssertNil(json.dictValue);
}

- (void) assertJSON:(JSON *)json isPrimitiveValue:(NSNumber *)value {
    XCTAssertEqual(json.intValue, value.intValue);
    XCTAssertEqual(json.doubleValue, value.doubleValue);
    XCTAssertEqual(json.floatValue, value.floatValue);
    XCTAssertEqual(json.boolValue, value.boolValue);
    XCTAssertEqualObjects(json.number, value);
    XCTAssertNotEqualObjects(json.number, @(value.intValue + 1));
    
    // Null for everything else
    XCTAssertNil(json.string);
    XCTAssertNil(json.array);
    XCTAssertNil(json.arrayValue);
    XCTAssertNil(json.dict);
    XCTAssertNil(json.dictValue);
}

@end
