//
//  AdaptiveSimpsonsRule.m
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import "AdaptiveSimpsonsRule.h"

#pragma mark - Private Interface Declarations:

@interface AdaptiveSimpsonsRule ()

// Recursive-adaptive logic method for ASR.
-(NSNumber*)recursiveASRfromPt:(NSNumber*)pt0
                          ToPt:(NSNumber*)pt2
                       WithEps:(NSNumber*)eps
               AndPreviousCalc:(NSNumber*)previousCalculation;

// Simpson's Rule.
-(NSNumber*)simpsonsRuleWithStart:(NSNumber*)x_0
                        AndFinish:(NSNumber*)x_2;

// The function being approximated by ASR.
-(NSNumber*)theFunctionValueAtPoint:(NSNumber*)x;

@end


#pragma mark - Public Method Implementations:

@implementation AdaptiveSimpsonsRule

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(id)initWithPtA:(NSNumber *)ptA WithPtB:(NSNumber *)ptB AndEpsilon:(NSNumber *)eps
{
    self = [super init];
    if (self) {
        // Initializes & allocates memory for public properties.
        // Sets values based on incoming values.
        self.pointA = [[NSNumber alloc] initWithDouble:[ptA doubleValue]];
        self.pointB = [[NSNumber alloc] initWithDouble:[ptB doubleValue]];
        self.error  = [[NSNumber alloc] initWithDouble:[eps doubleValue]];
    }
    return self;
}

-(NSNumber*)approximateUsingAdaptiveSimpsonsRule
{
    NSNumber* initialApproximation = [self simpsonsRuleWithStart:self.pointA
                                                       AndFinish:self.pointB];
    
    NSNumber* finalApproximation = [self recursiveASRfromPt:self.pointA
                                                       ToPt:self.pointB
                                                    WithEps:self.error
                                            AndPreviousCalc:initialApproximation];
    
    return finalApproximation;
}

#pragma mark - Private Method Implementations:

-(NSNumber*)recursiveASRfromPt:(NSNumber*)pt0
                          ToPt:(NSNumber*)pt2
                       WithEps:(NSNumber*)eps
               AndPreviousCalc:(NSNumber*)previousCalculation;
{
    // FInds the midpoint between pt0 and pt2.
    NSNumber* pt1 = [NSNumber numberWithDouble: ([pt0 doubleValue] + [pt2 doubleValue])/2 ];
    
    // Calculates the left side of the interval.
    NSNumber* left  = [self simpsonsRuleWithStart:pt0 AndFinish:pt1];
    
    // Calculates the right side of the interval.
    NSNumber* right = [self simpsonsRuleWithStart:pt1 AndFinish:pt2];
    
    // Calculates the difference between the two current halves and the previous whole.
    NSNumber* CurrentPreviousDifference = [NSNumber numberWithDouble:
                                           ([left doubleValue]+[right doubleValue]-[previousCalculation doubleValue]) ];
    
    // Compares the difference with the error term. If less than or equal to...
    if ( fabs([CurrentPreviousDifference doubleValue]) <= (15.0*[eps doubleValue]) )
    {
        // Calculates the result.
        NSNumber* result = [NSNumber numberWithDouble:
                            ( [left doubleValue]+[right doubleValue]+[CurrentPreviousDifference doubleValue]/15 ) ];
        
        // Returns the result to calling method.
        return result;
    }
    
    // Else...
    // We will recursively try to find a better solution for the left half...
    NSNumber* leftRecursion = [self recursiveASRfromPt:pt0
                                                  ToPt:pt1
                                               WithEps:[NSNumber numberWithDouble:[self.error doubleValue]/2]
                                       AndPreviousCalc:left];
    
    // And the right half.
    NSNumber* rightRecursion = [self recursiveASRfromPt:pt1
                                                   ToPt:pt2
                                                WithEps:[NSNumber numberWithDouble:[self.error doubleValue]/2]
                                        AndPreviousCalc:right];
    
    // Combines and returns the two recursive results.
    return [NSNumber numberWithDouble:[leftRecursion doubleValue]+[rightRecursion doubleValue]];
}

-(NSNumber*)simpsonsRuleWithStart:(NSNumber*)x_0
                        AndFinish:(NSNumber*)x_2
{
    // Calculates the midpoint between points x_0 and x_2.
    NSNumber* x_1 = [NSNumber numberWithDouble: ([x_0 doubleValue] + [x_2 doubleValue]) / 2.0];
    
    // Calculates the leading h/6 term.
    NSNumber* hOver6 = [NSNumber numberWithDouble: fabs([x_0 doubleValue] - [x_2 doubleValue]) / 6.0];
    
    // Evaluates the function value at point x_0.
    NSNumber* functAtPntX_0 = [self theFunctionValueAtPoint:[NSNumber numberWithDouble:[x_0 doubleValue]]];
    
    // Evaluates the function value at point x_1.
    NSNumber* functAtPntX_1 = [self theFunctionValueAtPoint:[NSNumber numberWithDouble:[x_1 doubleValue]]];
    
    // Evaluates the function value at point x_2.
    NSNumber* functAtPntX_2 = [self theFunctionValueAtPoint:[NSNumber numberWithDouble:[x_2 doubleValue]]];
    
    // Calculates the approximation of the integral between points x_0 and x_2.
    NSNumber* approximation = [NSNumber numberWithDouble:
                                                       [hOver6 doubleValue] * ([functAtPntX_0 doubleValue]
                                                       + 4.0 * [functAtPntX_1 doubleValue]
                                                       + [functAtPntX_2 doubleValue])];
    
    // Returns the approximation.
    return approximation;
}

-(NSNumber*)theFunctionValueAtPoint:(NSNumber*)x
{
    // ERROR CHECK: If function cannot handle certain operations (e.g. dividing by zero) test for
    // that here, print error message, and quit program. Must be updated along with the function
    // definition. Function MAY NOT NEED this error checking feature.
    
    /*
    if ( fabs([x doubleValue]) < (1*pow(10,-10)) )
    {
        NSLog(@"ERROR... Attempted to divide by zero."); exit(0);
    }
     */
    
    // Manually coded function definition.
    NSNumber* functionValueAtX = [NSNumber numberWithDouble: cos(pow([x doubleValue], 2)) ];
    
    // Returns the function value at point.
    return functionValueAtX;
}

@end
