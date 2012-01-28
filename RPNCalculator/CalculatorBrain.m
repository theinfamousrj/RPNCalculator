//
//  CalculatorBrain.m
//  RPNCalculator
//
//  Created by theinfamousrj on 1/27/12.
//  Copyright (c) 2012 theinfamousrj. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack {
    
    // lazy instantiation
    if(_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)pushOperand:(double)operand; {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

//- (double) popOperand {
//    NSNumber *operandObject = [self.programStack lastObject];
//    if(operandObject) [[self programStack] removeLastObject];
//    return [operandObject doubleValue];
//}

- (double)performOperation:(NSString *)operation; {
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program {
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program {
    return @"implement this";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if([operation isEqualToString:@"-"]) {
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        } else if([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if(divisor) result = [self popOperandOffStack:stack] / divisor;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

@end
