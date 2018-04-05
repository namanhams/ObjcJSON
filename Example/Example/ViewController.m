//
//  ViewController.m
//  Example
//
//  Created by Pham  on 5/4/18.
//  Copyright © 2018 Pham Le. All rights reserved.
//

#import "ViewController.h"
#import "JSON.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData:^(NSData *data) {
        if(! data)
            return;
        
        NSError *jsonError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(!jsonObject)
            return;
        
        NSLog(@"%@", [self typicalJSONCode:jsonObject]);
        NSLog(@"%@", [self awesomeJSONCode:jsonObject]);
    }];
}

- (void) fetchData:(void (^)(NSData *))onComplete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/books/v1/volumes?q=isbn:0747532699"];
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            onComplete(data);
        });
    });
}

// Print the first author name
- (NSString *) typicalJSONCode:(id)jsonObject {
    if(! [jsonObject isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSDictionary *dict = (NSDictionary *) jsonObject;
    if(! [dict[@"items"] isKindOfClass:[NSArray class]])
        return nil;
    
    NSArray *items = (NSArray *) dict[@"items"];
    if(! [items.firstObject isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSDictionary *firstItem = (NSDictionary *) items[0];
    if(! [firstItem[@"volumeInfo"] isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSDictionary *volumeInfo = (NSDictionary *) firstItem[@"volumeInfo"];
    if(! [volumeInfo[@"authors"] isKindOfClass:[NSArray class]])
        return nil;
    
    NSArray *authors = (NSArray *) volumeInfo[@"authors"];
    if(! [authors.firstObject isKindOfClass:[NSString class]])
        return nil;
    
    return (NSString *) authors.firstObject;
}

// Print the first author name
- (NSString *) awesomeJSONCode:(id)jsonObject {
    JSON *json = [[JSON alloc] initWithJsonObject:jsonObject];
    return json[@"items"][0][@"volumeInfo"][@"authors"][0].string;
}

@end
