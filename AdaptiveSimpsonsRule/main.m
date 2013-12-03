//
//  main.m
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

#import <Foundation/Foundation.h>
#import "AdaptiveSimpsonsRule.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        NSNumber* pointA = [NSNumber numberWithDouble: 0  ]; // Interval starting point value.
        NSNumber* pointB = [NSNumber numberWithDouble: 10 ]; // Interval stopping point value.
        
        // Error tolerance for ASR.
        NSNumber* error  = [NSNumber numberWithDouble: pow(10, -7) ]; // Breaks before -7.67
        
        // Allocate & intialize ASR object with start, stop, and error tolerance.
        AdaptiveSimpsonsRule* ASR = [[AdaptiveSimpsonsRule alloc] initWithPtA:pointA
                                                                      WithPtB:pointB
                                                                   AndEpsilon:error];
        
        // ASR object sends message to approximate the integral of the function
        // (whose definition is hard coded in implementation file).
        // NSNumber object then stores the approximation.
        NSNumber* approximation = [ASR approximateUsingAdaptiveSimpsonsRule];
        
        // Log that displays the approximation's value to the terminal.
        NSLog(@"Approximation of f(x) is %f.",[approximation doubleValue]);
    }
    return 0;
}

