//
//  AdaptiveSimpsonsRule.m
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Middle Tennessee State University, MATH 4310, Programming Assignment 2
//  Due by Tuesday, 26 November 2013.
//
//  Description of Program:
//  This is a command line tool designed to approximate the integral of a function
//  along a given interval using the method of Simpson’s Rule adaptively. The
//  function definition is hard coded into the implementation file and the interval’s
//  start & stop points are entered into the function main manually. The error
//  tolerance that is used to test whether the current approximation is good enough is
//  also entered manually. The approximation value is outputted to the terminal via NSLog.
//

#import "AdaptiveSimpsonsRule.h"

#pragma mark - Private Interface Declarations:
@interface AdaptiveSimpsonsRule ()

// Recursive-adaptive logic method for ASR (pre-declaration).
-(NSNumber*)recursiveASRfromPt:(NSNumber*)pt0
                          ToPt:(NSNumber*)pt2
                       WithEps:(NSNumber*)eps
               AndPreviousCalc:(NSNumber*)previousCalculation;

// Simpson's Rule (pre-declaration).
-(NSNumber*)simpsonsRuleWithStart:(NSNumber*)x_0
                        AndFinish:(NSNumber*)x_2;

// The function being approximated by ASR (pre-declaration).
-(NSNumber*)theFunctionValueAtPoint:(NSNumber*)x;

@end

#pragma mark - Public Method Implementations:
@implementation AdaptiveSimpsonsRule

/*
 METHOD: init
 ------------
 This is the default initializater mandated by Objective C objects that 
 inherit from the NSObject (foundation object).
 */
- (id)init
{
    self = [super init];
    if (self) { /* STUB */ }
    return self;
}

/*
 METHOD: initWithPtA: WithPtB: AndEpsilon:
 -----------------------------------------
 This is a custom intializer that allocates, intializes, and sets the 
 values for the object's properties.
 */
-(id)initWithPtA:(NSNumber *)ptA
         WithPtB:(NSNumber *)ptB
      AndEpsilon:(NSNumber *)eps
{
    self = [super init];
    if (self)
    {
        // Initializes & allocates memory for public properties.
        // Sets property values to received values.
        self.pointA = [[NSNumber alloc] initWithDouble:[ptA doubleValue]];
        self.pointB = [[NSNumber alloc] initWithDouble:[ptB doubleValue]];
        self.error  = [[NSNumber alloc] initWithDouble:[eps doubleValue]];
    }
    return self;
}

/*
 METHOD: approximateUsingAdaptiveSimpsonsRule
 --------------------------------------------
 This method sets the recursive logic of ASR into motion and returns the 
 value to ASR object.
 */
-(NSNumber*)approximateUsingAdaptiveSimpsonsRule
{
    // Calculates the initial approximation by ASR.
    NSNumber* initialApproximation = [self simpsonsRuleWithStart:self.pointA
                                                       AndFinish:self.pointB];
    
    // Using recursive logic, calculates the final approximation by ASR.
    NSNumber* finalApproximation = [self recursiveASRfromPt:self.pointA
                                                       ToPt:self.pointB
                                                    WithEps:self.error
                                            AndPreviousCalc:initialApproximation ];
    
    // Returns the final approximation.
    return finalApproximation;
}

#pragma mark - Private Method Implementations:

/*
 METHOD: recursiveASRfromPt: ToPt: WithEps: AndPreviousCalc:
 -----------------------------------------------------------
 This is the recursive logic for ASR. It receives an interval, error tolerance, 
 and a previous calculationg. Then it breaks the interval into left and right 
 halves, performs Simpson's Rule on each, compares the results of the left plus 
 the right with the previous calculation. If this comparison difference is 
 less than the error tolerance then the result is calculated & returned. Else, 
 this method is recursively called for both the left & right halves. The left & 
 right recursion results are then summed and returned.
 */
-(NSNumber*)recursiveASRfromPt:(NSNumber*)pt0
                          ToPt:(NSNumber*)pt2
                       WithEps:(NSNumber*)eps
               AndPreviousCalc:(NSNumber*)previousCalculation
{
    // Finds the midpoint between pt0 and pt2.
    NSNumber* pt1 = [NSNumber numberWithDouble: ([pt0 doubleValue] + [pt2 doubleValue]) / 2 ];
    
    // Calculates the left side of the interval using simpson's rule.
    NSNumber* left  = [self simpsonsRuleWithStart:pt0 AndFinish:pt1];
    
    // Calculates the right side of the interval using simpson's rule.
    NSNumber* right = [self simpsonsRuleWithStart:pt1 AndFinish:pt2];
    
    // Calculates the difference between the two current halves (together)
    // and the previous whole.
    NSNumber* CurrentPreviousDifference = [NSNumber numberWithDouble:
                                           ( [left doubleValue] + [right doubleValue]
                                            - [previousCalculation doubleValue] ) ];
    
    // Compares the difference with the error term. If less than or equal to...
    if ( fabs([CurrentPreviousDifference doubleValue]) <= (15.0*[eps doubleValue]) )
    {
        // ... calculate the result.
        NSNumber* result = [NSNumber numberWithDouble:
                            ( [left  doubleValue]
                             +[right doubleValue]
                             +[CurrentPreviousDifference doubleValue] / 15.0 ) ];
        
        // Returns the result to calling method.
        return result;
    }
    
    // Else...
    // We will recursively try to find a better solution for the left half of the interval...
    NSNumber* leftRecursion = [self recursiveASRfromPt:pt0
                                                  ToPt:pt1
                                               WithEps:[NSNumber numberWithDouble:
                                                        [eps doubleValue]/2.0]
                                       AndPreviousCalc:left];
    
    // ... and the right half of the interval.
    NSNumber* rightRecursion = [self recursiveASRfromPt:pt1
                                                   ToPt:pt2
                                                WithEps:[NSNumber numberWithDouble:
                                                         [eps doubleValue]/2.0]
                                        AndPreviousCalc:right];
    
    // Combines and returns the two recursive results.
    return [NSNumber numberWithDouble: [leftRecursion doubleValue]+[rightRecursion doubleValue] ];
}

/*
 METHOD: simpsonRulesWithStart: AndFinish:
 -----------------------------------------
 This is the standard definition of Simpson's Rule. It takes an interval, 
 finds the midpoint, calculates the function value at all 3 points (start, 
 mid, & stop), and returns the weight average approximation of integral 
 within the received interval.
 */
-(NSNumber*)simpsonsRuleWithStart:(NSNumber*)x_0
                        AndFinish:(NSNumber*)x_2
{
    // Calculates the midpoint between points x_0 and x_2.
    NSNumber* x_1 = [NSNumber numberWithDouble: ([x_0 doubleValue] + [x_2 doubleValue]) / 2.0];
    
    // Calculates the leading h/6 term.
    NSNumber* hOVER6 = [NSNumber numberWithDouble: fabs([x_0 doubleValue]-[x_2 doubleValue])/6.0 ];
    
    // Evaluates the function value at point x_0 (interval start).
    NSNumber* functAtPntX_0 = [self theFunctionValueAtPoint:
                               [NSNumber numberWithDouble:[x_0 doubleValue]]];
    
    // Evaluates the function value at point x_1 (interval midpt).
    NSNumber* functAtPntX_1 = [self theFunctionValueAtPoint:
                               [NSNumber numberWithDouble:[x_1 doubleValue]]];
    
    // Evaluates the function value at point x_2 (interval stop).
    NSNumber* functAtPntX_2 = [self theFunctionValueAtPoint:
                               [NSNumber numberWithDouble:[x_2 doubleValue]]];
    
    // Calculates the approximation of the integral between points x_0 and x_2.
    NSNumber* approximation = [NSNumber numberWithDouble:
                                               [hOVER6 doubleValue] * ( [functAtPntX_0 doubleValue]
                                               + 4.0 * [functAtPntX_1 doubleValue]
                                               + [functAtPntX_2 doubleValue] ) ];
    
    /*
    // Checks to see if approximation should be considered "zero"...
    if ( fabs([approximation doubleValue]) < pow(10, -10) )
    {
        return [NSNumber numberWithDouble:0.0];
    }
    */
    
    // Returns the approximation.
    return approximation;
}

/*
 METHOD: theFunctionValueAtPoint:
 --------------------------------
 Receives x-value for a point, calculates & returns y-value ( f(x) ) using a hard
 coded function definition. There can be an error checking feature. Needs to 
 implemented along with the function definition.
 */
-(NSNumber*)theFunctionValueAtPoint:(NSNumber*)x
{
    // ERROR CHECK:
    // If function cannot handle certain operations (e.g. dividing by zero) test for
    // that here, print error message, and quit program. Must be updated along with
    // the function definition. Function MAY NOT NEED this error checking feature.
    
    /*
    if ( fabs([x doubleValue]) < (1*pow(10,-10)) )
    {
        NSLog(@"ERROR... Attempted to divide by zero."); exit(0);
    }
     */
    
    // FUNCITON DEFINITION:
    // Manually coded function definition.
     NSNumber* functionValueAtX = [NSNumber numberWithDouble: pow(M_E, pow(-[x doubleValue], 3)) * sin([x doubleValue]) ];
    
    //NSNumber* functionValueAtX = [NSNumber numberWithDouble: cos(pow([x doubleValue], 2)) ];
    
    // Returns the function value at point.
    return functionValueAtX;
}

@end