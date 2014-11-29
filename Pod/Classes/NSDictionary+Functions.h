//
//  NSDictionary+Functions.h
//  
//
//  Created by Rasmus Kildevaeld on 11/11/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Functions)

@property (nonatomic, copy, readonly) void (^each)(void (^fn)(id key, id value, BOOL *stop));
@property (nonatomic, copy, readonly) NSDictionary *(^extend)(NSDictionary *dict);


@end
