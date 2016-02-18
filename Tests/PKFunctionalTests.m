//
//  PKFunctionalTests.m
//  PKFunctionalTests
//
//  Created by Philip Kluz on 9/10/15.
//  Copyright (c) 2015 nsexpcetional.com. All rights reserved.
//

@import UIKit;
@import XCTest;
@import PKFunctional;

@interface PKFunctionalTests : XCTestCase

@end

@implementation PKFunctionalTests


- (void)testArrayMapEmpty
{
    NSArray *numbers = @[];
    NSArray *expected = @[];
    
    NSArray *result = [numbers pk_map:nil];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of map (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMap
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expected = [self arrayOfNumbersIncremented];
    
    NSArray *result = [numbers pk_map:^NSNumber *(NSNumber *number)
                       {
                           return @([number integerValue] + 1);
                       }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of map (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMapIndexEmpty
{
    NSArray *numbers = @[];
    NSArray *expected = @[];
    
    NSArray *result = [numbers pk_mapIndex:nil];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of mapIndex (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayMapIndex
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expected = [self arrayOfNumbersIncremented];
    
    NSArray *result = [numbers pk_mapIndex:^NSNumber *(NSNumber *number, NSUInteger idx)
                       {
                           NSLog(@"Index: %@", @(idx));
                           return @([number integerValue] + 1);
                       }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of mapIndex (= %@) did not match expected value (= %@).", result, expected);
}

- (void)testArrayFilter
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *evenNumbers = [self arrayOfEvenNumbers];
    
    NSArray *result = [numbers pk_filter:^BOOL(NSNumber *number)
                       {
                           return [number integerValue] % 2 == 0;
                       }];
    
    XCTAssert([evenNumbers isEqualToArray:result], @"Error: Result of filter (= %@) did not match expected value (= %@).", result, evenNumbers);
}

- (void)testArrayReversal
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *reversed = [self reversedArrayOfNumbers];
    
    NSArray *result = [numbers pk_reverse];
    
    XCTAssert([reversed isEqualToArray:result], @"Error: Result of array reversal (= %@) did not match expected value (= %@).", result, reversed);
}

- (void)testArrayTail
{
    NSArray *numbers = [self arrayOfEvenNumbers];
    NSArray *tail = [self evenNumbersTail];
    
    NSArray *result = [numbers pk_tail];
    
    XCTAssert([tail isEqualToArray:result], @"Error: Result of array tail (= %@) did not match expected value (= %@).", result, tail);
}

- (void)testArrayInitial
{
    NSArray *numbers = [self arrayOfEvenNumbers];
    NSArray *initial = [self evenNumbersInitial];
    
    NSArray *result = [numbers pk_initial];
    
    XCTAssert([initial isEqualToArray:result], @"Error: Result of array initial (= %@) did not match expected value (= %@).", result, initial);
}

- (void)testArrayTake
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [self arrayOfNumbersTake3];
    
    NSArray *result = [numbers pk_take:3];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 3 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeZero
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [NSArray array];
    
    NSArray *result = [numbers pk_take:0];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 0 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeMax
{
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *take = [self arrayOfNumbers];
    
    NSArray *result = [numbers pk_take:99];
    
    XCTAssert([take isEqualToArray:result], @"Error: Result of array take 99 (= %@) did not match expected value (= %@).", result, take);
}

- (void)testArrayTakeWhile
{
    // Random:
    NSArray *numbers = [self arrayOfNumbers];
    NSArray *expectedResult = [self arrayOfNumbersTake3];
    
    NSArray *result = [numbers pk_takeWhile:^BOOL(NSNumber *number)
                       {
                           return [number integerValue] < 3;
                       }];
    
    XCTAssert([expectedResult isEqualToArray:result], @"Error: Result of array take while < 3 (= %@) did not match expected value (= %@).", result, expectedResult);
    
    // Empty Result:
    NSArray *expectedResultEmpty = [NSArray array];
    
    NSArray *resultEmpty = [numbers pk_takeWhile:^BOOL(NSNumber *number)
                            {
                                return NO;
                            }];
    
    XCTAssert([expectedResultEmpty isEqualToArray:resultEmpty], @"Error: Result of array take while NO (= %@) did not match expected value (= %@).", resultEmpty, expectedResultEmpty);
    
    // All Result:
    NSArray *expectedResultAll = [numbers copy];
    
    NSArray *resultAll = [numbers pk_takeWhile:^BOOL(NSNumber *number)
                          {
                              return YES;
                          }];
    
    XCTAssert([expectedResultAll isEqualToArray:resultAll], @"Error: Result of array take while YES (= %@) did not match expected value (= %@).", resultAll, expectedResultAll);
}

- (void)testFlatten
{
    NSArray *numbers = @[@[@0, @1], @[@2, @[@3, @4], @5, @[@6, @7, @8, @[@9], @[]]]];
    NSArray *expectedResult = [self arrayOfNumbers];
    
    NSArray *result = [numbers pk_flatten];
    
    XCTAssert([expectedResult isEqualToArray:result], @"Error: Result of array flattening (= %@) did not match expected value (= %@).", result, expectedResult);
}

- (void)testArrayMinimum
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expectedMinimum = @0;
    
    id minimum = [numbers pk_minimum];
    
    XCTAssert([minimum isEqualToNumber:expectedMinimum], @"Error: Result of minimum (= %@) did not match expected value (= %@)", minimum, expectedMinimum);
}

- (void)testArrayMaximum
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expectedMaximum = @9;
    
    id maximum = [numbers pk_maximum];
    
    XCTAssert([maximum isEqualToNumber:expectedMaximum], @"Error: Result of maximum (= %@) did not match expected value (= %@)", maximum, expectedMaximum);
}

- (void)testArraySecondObject
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *expected = @1;
    
    id result = [numbers pk_secondObject];
    
    XCTAssert([expected isEqualToNumber:result], @"Error: Result of second object (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZip
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = @[@[@0, @0], @[@1, @1], @[@2, @2]];
    
    NSArray *result = [numbers1 pk_zip:numbers2];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of zip (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZipUsing
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = @[@0, @2, @4];
    
    NSArray *result = [numbers1 pk_zip:numbers2 using:^id(id obj1, id obj2) {
        return @([obj1 integerValue] + [obj2 integerValue]);
    }];
    
    XCTAssert([expected isEqualToArray:result], @"Error: Result of zip:using: (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayZipUsingNil
{
    NSArray *numbers1 = [self arrayOfNumbers];
    NSArray *numbers2 = [self arrayOfNumbersTake3];
    NSArray *expected = nil;
    
    NSArray *result = [numbers1 pk_zip:numbers2 using:nil];
    
    XCTAssert(expected == result, @"Error: Result of zip:using: (= %@) did not match expected value (= %@)", result, expected);
}

- (void)testArrayFoldr
{
    NSArray *numbers = [self arrayOfNumbers];
    NSNumber *sum = @(45);
    
    NSNumber *result = [numbers pk_foldr:@(0) block:^NSNumber *(NSNumber *number, NSNumber *obj)
                        {
                            return @([number integerValue] + [obj integerValue]);
                        }];
    
    XCTAssert([sum isEqualToNumber:result], @"Error: Result of array foldl (= %@) did not match expected value (= %@).", result, sum);
}

- (void)testArrayFoldl
{
    NSArray *numbers = [self arrayOfDivisibleNumbers];
    NSNumber *quotient = @(2);
    
    NSNumber *result = [numbers pk_foldl:@(256) block:^NSNumber *(NSNumber *number, NSNumber *obj)
                        {
                            return @([number floatValue] / [obj floatValue]);
                        }];
    
    XCTAssert([quotient isEqualToNumber:result], @"Error: Result of array foldl (= %@) did not match expected value (= %@).", result, quotient);
}

- (void)testArrayAny
{
    BOOL anyThrees = [[self arrayOfNumbers] pk_any:^BOOL(id obj) {
        return [obj integerValue] == 3;
    }];
    
    XCTAssert(anyThrees);
    
    BOOL anyOdds = [[self arrayOfEvenNumbers] pk_any:^BOOL(id obj) {
        return [obj integerValue] % 2 == 1;
    }];
    
    XCTAssertFalse(anyOdds);
}

- (void)testArrayFind
{
    NSArray *numbers = [self arrayOfNumbers];
    
    NSNumber *foundNumber = [numbers pk_find:^BOOL(id obj) {
        return [obj integerValue] == 5;
    }];
    
    XCTAssert([foundNumber isEqualToNumber:@(5)]);
    
    foundNumber = [numbers pk_find:^BOOL(id obj) {
        return [obj integerValue] == 1234;
    }];
    
    XCTAssertNil(foundNumber);
}


#pragma mark - Test Data

- (NSArray *)arrayOfNumbers
{
    return @[@(0), @(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9)];
}

- (NSArray *)arrayOfNumbersTake3
{
    return @[@(0), @(1), @(2)];
}

- (NSArray *)arrayOfDivisibleNumbers
{
    return @[@(16), @(1), @(2), @(4)];
}

- (NSArray *)reversedArrayOfNumbers
{
    return @[@(9), @(8), @(7), @(6), @(5), @(4), @(3), @(2), @(1), @(0)];
}

- (NSArray *)arrayOfEvenNumbers
{
    return @[@(0), @(2), @(4), @(6), @(8)];
}

- (NSArray *)evenNumbersTail
{
    return @[@(2), @(4), @(6), @(8)];
}

- (NSArray *)evenNumbersInitial
{
    return @[@(0), @(2), @(4), @(6)];
}

- (NSArray *)arrayOfOddNumbers
{
    return @[@(1), @(3), @(5), @(7), @(9)];
}

- (NSArray *)arrayOfNumbersIncremented
{
    return @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10)];
}

@end
