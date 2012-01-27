//
//  RPNCalculatorViewController.m
//  RPNCalculator
//
//  Created by theinfamousrj on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RPNCalculatorViewController.h"
#import "CalculatorBrain.h"

@interface RPNCalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringData;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation RPNCalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringData = _userIsInTheMiddleOfEnteringData;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    
    // lazy instantiation
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if(self.userIsInTheMiddleOfEnteringData) {
        [[self display] setText:[[[self display] text] stringByAppendingString:digit]];
    } else {
        [[self display] setText:digit];
        [self setUserIsInTheMiddleOfEnteringData:YES];
    }
}

- (IBAction)enterPressed {
    [[self brain] pushOperand:[self.display.text doubleValue]];
    [self setUserIsInTheMiddleOfEnteringData:NO];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringData) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
@end
