/*
    PKFunctional > NSArray+PKFunctional.m
 
    The MIT License (MIT)
 
    Copyright (c) 2015 Philip Kluz
 
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
 
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
 
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
 */

#import "NSArray+PKFunctional.h"

@implementation NSArray (PKFunctional)

- (NSArray *)pk_map:(id (^)(id obj))func
{
    return [[self pk_foldl:[NSMutableArray array]
                     block:^id(NSMutableArray *acc, id obj) {
        [acc addObject:func(obj)];
        return acc;
    }] copy];
}

- (NSArray *)pk_mapIndex:(id (^)(id obj, NSUInteger idx))func
{
    return [[self pk_foldlIndex:[NSMutableArray array]
                          block:^id(NSMutableArray *acc, id obj, NSUInteger idx) {
        [acc addObject:func(obj, idx)];
        return acc;
    }] copy];
}

- (NSArray *)pk_filter:(BOOL (^)(id obj))func
{
    return [[self pk_foldlIndex:[NSMutableArray array]
                          block:^id(NSMutableArray *acc, id obj, NSUInteger idx) {
        if (func(obj)) {
            [acc addObject:obj];
        }
        return acc;
    }] copy];
}

- (NSArray *)pk_reverse
{
    return [[self pk_foldr:[NSMutableArray array]
                     block:^id(NSMutableArray *acc, id obj) {
        [acc addObject:obj];
        return acc;
    }] copy];
}

- (NSArray *)pk_tail
{
    if ([self count] == 0) {
        return nil;
    }
    
    return [self subarrayWithRange:NSMakeRange(1, [self count] - 1)];
}

- (NSArray *)pk_initial
{
    if ([self count] == 0) {
        return nil;
    }
    
    return [self subarrayWithRange:NSMakeRange(0, [self count] - 1)];
}

- (NSArray *)pk_take:(NSUInteger)value
{
    return [self subarrayWithRange:NSMakeRange(0, MIN(value, [self count]))];
}

- (NSArray *)pk_takeWhile:(BOOL (^)(id obj))func
{
    if (!func) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if (func(obj)) {
            [result addObject:obj];
        } else {
            break;
        }
    }
    
    return [result copy];
}

- (NSArray *)pk_flatten
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [result addObjectsFromArray:[obj pk_flatten]];
        } else {
            [result addObject:obj];
        }
    }
    
    return [result copy];
}

- (NSArray *)pk_sort
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (id)pk_secondObject
{
    if ([self count] > 1) {
        return self[1];
    }
    
    return nil;
}

- (id)pk_maximum
{
    return [[self pk_sort] lastObject];
}

- (id)pk_minimum
{
    return [[self pk_sort] firstObject];
}

- (NSArray *)pk_zip:(NSArray *)array
{
    NSUInteger resultLength = MIN([self count], [array count]);
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < resultLength; i++) {
        [result addObject:@[self[i], array[i]]];
    }
    
    return [result copy];
}

- (NSArray *)pk_zip:(NSArray *)array using:(id (^)(id, id))func
{
    if (!func) {
        return nil;
    }
    
    return [[self pk_zip:array] pk_map:^id(NSArray *pair) {
        id first = [pair firstObject];
        id second = [pair pk_secondObject];
        
        return func(first, second);
    }];
}

- (id)pk_foldlIndex:(id)initial block:(id (^)(id acc, id obj, NSUInteger idx))func
{
    if (!func) {
        return nil;
    }
    
    id result = initial;
    
    for (int i = 0; i < self.count; i++) {
        result = func(result, self[i], i);
    }
    
    return result;
}

- (id)pk_foldrIndex:(id)initial block:(id (^)(id acc, id obj, NSUInteger idx))func
{
    if (!func) {
        return nil;
    }
    
    id result = initial;
    
    for (int i = (int)(self.count - 1); i >= 0; i--) {
        result = func(result, self[i], i);
    }
    
    return result;
}

- (id)pk_foldl:(id)initial block:(id (^)(id acc, id obj))func
{
    return [self pk_foldlIndex:initial
                         block:^id(id acc, id obj, NSUInteger _) {
        return func(acc, obj);
    }];
}

- (id)pk_foldr:(id)initial block:(id (^)(id acc, id obj))func
{
    return [self pk_foldrIndex:initial
                         block:^id(id acc, id obj, NSUInteger _) {
        return func(acc, obj);
    }];
}

- (BOOL)pk_any:(BOOL(^)(id obj))func
{
    for (id obj in self) {
        if (func(obj)) {
            return YES;
        }
    }
    
    return NO;
}

@end

