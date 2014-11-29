//
//  NSArray+Functions.m
//  
//
//  Created by Rasmus Kildevaeld on 07/11/14.
//
//

#import "NSArray+Functions.h"

@implementation NSArray (Functions)

- (NSArray *)shuffle
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSUInteger count = [self count];
    for (uint i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = (int)count - i;
        int n = arc4random_uniform(nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return [NSArray arrayWithArray:array];
}



- (void (^)(void (^)(id value, BOOL *stop)))each {
    return ^(void (^fn)(id value, BOOL *stop)) {
        BOOL stop = false;
        
        for (id value in self) {
            fn(value, &stop);
            if (stop == YES)
                break;
        }
    };
}

- (NSArray *(^)())flatten {
    return ^{
        NSMutableArray *ret = [NSMutableArray array];
        
        self.each(^(id value, BOOL *stop) {
            if ([value isKindOfClass:NSArray.class]) {
                NSArray *array = (NSArray *)value;
                id val = array.flatten();
                [ret addObjectsFromArray:val];
            } else {
                [ret addObject:value];
            }
        });
        
        return [NSArray arrayWithArray:ret];
    };
}

- (NSArray *(^)(id (^)(id value)))map {
    return ^(id (^fn)(id value)) {
        NSMutableArray *_result = [NSMutableArray arrayWithCapacity:self.count];
        
        for (id value in self) {
            @autoreleasepool {
                id result = fn(value);
                if (result != nil)
                    [_result addObject:result];
            }
            
        }
        return [NSArray arrayWithArray:_result];
    };

}

- (id (^)(BOOL (^)(id value)))findWhere {
    return ^(BOOL (^fn)(id value)) {
        __block id v;
        id result;
        
        self.each(^(id value, BOOL *stop) {
            if (fn(value)) {
                *stop = YES;
                v = value;
            }
        });
        if (v != nil)
            result = v;
        
        return result;
    };
}

- (NSArray *(^)(BOOL (^)(id value)))find {
    return ^(BOOL (^fn)(id value)) {
        NSMutableArray *array = [NSMutableArray array];
        
        self.each(^(id value, BOOL *stop) {
            if (fn(value)) {
                [array addObject:value];
            }
        });
        
        return [NSArray arrayWithArray:array];
    };
}

- (NSArray *(^)(NSString *property))pluck {
    return ^(NSString *property) {
        return self.map(^(id value) {
            return [value valueForKeyPath:property];
        });
    };
}

- (NSArray *(^)(NSArray *properties))pick {
    return ^(NSArray *properties) {
        return self.map(^(id value) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            
            properties.each(^(id prop, BOOL *stop) {
                id v = [value valueForKeyPath:prop];
                if (v != nil) {
                    dict[prop] = v;
                }
                
            });
            
            return [NSDictionary dictionaryWithDictionary:dict];
        });
    };
}

- (id (^)(id (^)(id prevValue, id curValue)))reduce {
    return ^(id (^fn)(id prevValue, id curValue)) {
        id i = self.first;
        if (i == nil)
            return (id)nil;
        
            
        return (id)nil;
    };
}

- (id )first {
    if (!self.empty)
        return [self objectAtIndex:0];
    return nil;
}

- (BOOL)empty {
    return self.count == 0;
}

@end
