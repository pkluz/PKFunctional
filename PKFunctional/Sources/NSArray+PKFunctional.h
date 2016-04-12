/*
    PKFunctional > NSArray+PKFunctional.h
 
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

@import Foundation;

@interface NSArray (PKFunctional)

/**
 *  Applies a function to every element of the array, producing a new array.
 *
 *  @param func Function that is applied across every element in the array.
 *
 *  @return Returns a new array containing the mapped objects.
 */
- (NSArray *)pk_map:(id (^)(id obj))func;

/**
 *  Applies of function to every element of the array, producing a new array.
 *
 *  @param func Function that is applied across every element in the array.
 *
 *  @return Returns a new array containing the mapped objects.
 */
- (NSArray *)pk_mapIndex:(id (^)(id obj, NSUInteger idx))func;

/**
 *  Filter applies a function to every element of the array, producing a new array of elements for which the filter function returned YES.
 *
 *  @param func Function that is applied across every element in the array, determining wheter to accept or filter the object that's being tested.
 *
 *  @return Returns a new array containing all the objects, which passed the filter test.
 */
- (NSArray *)pk_filter:(BOOL (^)(id obj))func;

/**
 *  Creates a reversed version of the array. (Last element becomes first,… etc.)
 *
 *  @return Reversed version of the array.
 */
- (NSArray *)pk_reverse;

/**
 *  Creates a new array containing every element, except for the first.
 *
 *  @return New array containing every element, except for the first.
 */
- (NSArray *)pk_tail;

/**
 *  Creates a new array containing every element, except for the last.
 *
 *  @return New array containing every element, except for the last.
 */
- (NSArray *)pk_initial;

/**
 *  Creates a new array containing the first x elements.
 *
 *  @param value Number of elements to take.
 *
 *  @return New Array containing the first `value` elements.
 */
- (NSArray *)pk_take:(NSUInteger)value;

/**
 *  Creates a new array containing the first x elements of the receiving array, for which the block evaluated to YES.
 *
 *  @param block Block returning YES or NO. Returning NO stops the take-process.
 *
 *  @return New Array containing the first x elements of the receiving array, for which the block evaluated to YES.
 */
- (NSArray *)pk_takeWhile:(BOOL(^)(id obj))block;

/**
 *  Recursively unwraps arrays of arrays and adds all objects into a single resulting array.
 *  Example: @[@[1,2,3], @[4,5, @[6, 7]]] -> @[1,2,3,4,5,6,7]
 *
 *  @return Recursively unwrapped array.
 */
- (NSArray *)pk_flatten;

/**
 *  Given all the elements in the array can be sorted using the default `compare:` method, the method returns a sorted representation of the array.
 *
 *  @return Sorted representation of the array.
 */
- (NSArray *)pk_sort;

/**
 *  The second object (if present) or nil.
 *
 *  @return The second object (if present) or nil.
 */
- (id)pk_secondObject;

/**
 *  Given all the elements in the array can be ordered, the method finds the minimum.
 *
 *  @return Minimal object in the array.
 */
- (id)pk_minimum;

/**
 *  Given all the elements in the array can be ordered, the method finds the maximum.
 *
 *  @return Maximal object in the array.
 */
- (id)pk_maximum;

/**
 *  Pairs the receivers elements with the corresponding ones from the input array. If the lists are of different length, the resulting list will have the shorter length.
 *
 *  @param array Array to pair the receivers corresponding elements with.
 *
 *  @return Array of pairs (NSArrays of length 2).
 */
- (NSArray *)pk_zip:(NSArray *)array;

/**
 *  Merges the receivers elements with the corresponding ones from the input array by evaluating the zip function. If the lists are of different length, the resulting list will have the shorter length.
 *
 *  @param array Array to merge the receivers corresponding elements with.
 *  @param func  Function that reduces a matching pair into a single value.
 *
 *  @return Array of zipped elements.
 */
- (NSArray *)pk_zip:(NSArray *)array using:(id(^)(id obj1, id obj2))func;

/**
 *  Reduces a collection into a single value by folding from the left.
 *
 *  @param initial The starting value of the fold.
 *  @param func    Function that takes the merged value of all the values up to a certain point as well as the following object. Returns a merged result.
 *
 *  @return A single value, which all other values have been folded into.
 */
- (id)pk_foldl:(id)initial block:(id(^)(id acc, id obj))func;

/**
 *  Reduces a collection into a single value by folding from the right.
 *
 *  @param initial The starting value of the fold.
 *  @param func    Function that takes the merged value of all the values up to a certain point as well as the following object. Returns a merged result.
 *
 *  @return A single value, which all other values have been folded into.
 */
- (id)pk_foldr:(id)initial block:(id(^)(id acc, id obj))func;

/**
 *  Returns whether or not any array element passes the function.
 *
 *  @param func Function applied to each element until it passes.
 *
 *  @return Boolean, YES if any elements matches, NO otherwise.
 */
- (BOOL)pk_any:(BOOL(^)(id obj))func;

/**
 *  Finds the first element in the array that passes the function. If no such element exists, nil is returned.
 *
 *  @param func Function applied to each element until it passes.
 *
 *  @return An object from the array that passes the function, or nil.
 */
- (id)pk_find:(BOOL(^)(id obj))func;

/**
 *  Applies the function to each element of the array.
 *
 *  @param func Function applied to each element.
 */
- (void)pk_each:(void (^)(id obj))func;

@end

