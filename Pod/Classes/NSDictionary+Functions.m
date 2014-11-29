//
//  NSDictionary+Functions.m
//  
//
//  Created by Rasmus Kildevaeld on 11/11/14.
//
//

#import "NSDictionary+Functions.h"

@implementation NSDictionary (Functions)

- (void (^)(void (^)(id key, id value, BOOL *stop)))each {
    return ^(void (^fn)(id key, id value, BOOL *stop)) {
        BOOL stop = false;
        
        for (id key in self.allKeys) {
            id value = self[key];
            fn(key, value, &stop);
            if (stop == YES)
                break;
        }
    };
}

- (NSDictionary *(^)(NSDictionary *dict))extend {
    return ^(NSDictionary *dict) {
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self];
        
        dict.each(^(id key, id value, BOOL *stop) {
            result[key] = value;
        });
        
        return [NSDictionary dictionaryWithDictionary:result];
    };
}

@end
