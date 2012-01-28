//
//  CalculatorBrain.h
//  RPNCalculator
//
//  Created by theinfamousrj on 1/27/12.
//  Copyright (c) 2012 theinfamousrj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
