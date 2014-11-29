//
//  NSArray+Functions.h
//  
//
//  Created by Rasmus Kildevaeld on 07/11/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (Functions)

//@property (nonatomic, copy, readonly) void (^forEach)(void (^fn)(id value, BOOL *stop)) __deprecated;
@property (nonatomic, copy, readonly) void (^each)(void (^fn)(id value, BOOL *stop));

@property (nonatomic, copy, readonly) NSArray * (^flatten)();

@property (nonatomic, copy, readonly) NSArray *(^map)(id (^fn)(id value));

@property (nonatomic, copy, readonly) id (^findWhere)(BOOL (^fn)(id value));

@property (nonatomic, copy, readonly) NSArray *(^find)(BOOL (^fn)(id value));

@property (nonatomic, copy, readonly) NSArray *(^pluck)(NSString *property);

@property (nonatomic, copy, readonly) NSArray *(^pick)(NSArray *properties);

@property (nonatomic, copy, readonly) id (^reduce)(id (^)(id prevValue, id currentValue));

//@property (nonatomic, copy, readonly) NSArray *(^difference)(NSArray *a);

@property (nonatomic, weak, readonly) id first;

@property (nonatomic, readonly) BOOL empty;

@property (nonatomic, weak, readonly) NSArray *shuffle;

@end
