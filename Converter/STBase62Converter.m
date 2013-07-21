//
//  STBase62Converter.m
//  Converter
//
//  Created by Shri on 21/07/13.
//  Copyright (c) 2013 Shri. All rights reserved.
//

#import "STBase62Converter.h"
#include <math.h>

@interface STBase62Converter ()
-(void) readBaseArray;
-(void) checkDuplicates;
@end

@implementation STBase62Converter

-(id) init {
    if (self = [super init]) {
        self.baseArray = [[NSMutableArray alloc] init];
        [self readBaseArray];
    }
    return self;
}

-(void) readBaseArray {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BaseContent" ofType:@"txt"];
    NSString* fileContents = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];

    for (NSString *eachElement in lines)
        [self.baseArray addObject:eachElement];
    
    NSLog(@"Base %d", [self.baseArray count]);

    [self checkDuplicates];
}

-(NSString *) getBase62FromDecimal:(long long) number {
    NSLog(@"Original Number %lli",number);
    int baseCount = [self.baseArray count];
    long long quotient;
    long remainder;
    NSString *quotientString = @"";

    do {
        quotient = number / baseCount;
        remainder = number % baseCount;
        quotientString = [quotientString stringByAppendingString:[self.baseArray objectAtIndex:remainder]];

        number = quotient;
    } while (quotient > 0);
    
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [quotientString length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[quotientString substringWithRange:subStrRange]];
    }
    
    NSLog(@"Encrypted to: %@",reversedString);
    return reversedString;
}

-(long long) getDecimalFromBase62:(NSString *) number {
    
    int baseCount = [self.baseArray count];
    long long decimalNumber;
    
    for (int i =0; i<[number length]; i++) {
        NSString *singleValue = [number substringWithRange:NSMakeRange(i, 1)];
        NSUInteger index = [self.baseArray indexOfObject:singleValue];
        if (NSNotFound == index) {
            NSLog(@"Error");
            return 0;
        }
        long double newDouble =index * powl(baseCount, [number length] - i - 1);
        decimalNumber = decimalNumber + newDouble;
    }
    NSLog(@"Original Number %lli",decimalNumber);
    return decimalNumber;
}

- (void) checkDuplicates {
    NSArray *copy = [self.baseArray copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([self.baseArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            NSLog(@"ERROR... Dublicate object at index %d", index);
            NSLog(@"Conversion May no work properly");
        }
        index--;
    }
}

@end
