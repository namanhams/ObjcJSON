# ObjcJSON
A better way to deal to JSON data in Objective-C. 
Inspired by SwiftyJSON (<https://github.com/SwiftyJSON/SwiftyJSON>)
<b>Note</b>: this is not another JSON parsing library.

## Why do you need it ?

Let's say you use Google API to retrive info about some book, and you want to retrieve the author name. 
The code in Objective-C would look like this :
```objc
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
```

With ObjcJSON, this is all you need: 
```objc
- (NSString *) awesomeJSONCode:(id)jsonObject {
    JSON *json = [[JSON alloc] initWithJsonObject:jsonObject];
    return json[@"items"][0][@"volumeInfo"][@"authors"][0].string;
}
```

## Requirements

- iOS 8.0+
- XCode 9


## Integration

### Cocoapods

```
pod 'ObjcJSON', '1.0'
```

## Usage

Let say your json data is like this :
```
{ "speakers": [
	{ "firstname": "Ray",
		"lastname": "Villalobos",
		"category": "Front End",
		"title": "Bootstrap & CSS Preprocessors",
		"image": "http://barcampdeland.org/images/speaker_rayvillalobos.jpg",
		"link": "http://iviewsource.com",
		"bio": "Ray Villalobos is a full-time author and teacher at lynda.com. He is author of the book, Exploring Multimedia for Designers. He has more than 20 years experience in developing and programming multimedia projects. Previously at Entravision Communications, he designed and developed a network of radio station and TV web sites. As a senior producer for Tribune Interactive, he was responsible for designing orlandosentinel.com and for creating immersive multimedia projects and Flash games for the site.",
		"description": "As responsive design continues to take over the web, front-end developers and designers have turned to preprocessors and layout systems that simplify their workflow. Lynda.com staff author Ray Villalobos will talk about using the Bootstrap framework from Twitter to scaffold and fast track your responsive design. He'll talk about how you can use CodeKit and LESS to put together designs in hours instead of days."
	}
]}
```

You can access the 'bio' of the first speaker as following: 

```objc
import <ObjcJSON/ObjcJSON.h>

JSON *json = [[JSON alloc] initWithJsonObject:someObject];
NSString *bio = json[@"speakers"][0][@"bio"].string
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

This library exists thanks to the awesome SwiftyJSON

