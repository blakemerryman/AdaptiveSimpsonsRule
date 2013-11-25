//
//  AdaptiveSimpsonsRule.h
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Middle Tennessee State University, MATH 4310, Programming Assignment 2
//  Due by Tuesday, 26 November 2013.
//
//  Description of Program:
//  This is a command line tool designed to approximate the integral of a function along a given interval
//  using the method of Simpson’s Rule adaptively. The function definition is hard coded into the
//  implementation file and the interval’s start & stop points are entered into the function main manually.
//  The error tolerance that is used to test whether the current approximation is good enough is also
//  entered manually. The approximation value is outputted to the terminal via NSLog.
//

#import <Foundation/Foundation.h>

@interface AdaptiveSimpsonsRule : NSObject

#pragma mark - Public Properties:
@property(nonatomic)NSNumber* pointA;   // The start of the integral to approximate using ASR.
@property(nonatomic)NSNumber* pointB;   // The end of the integral to approximate using ASR.
@property(nonatomic)NSNumber* error;    // The error tolerance to be used in ASR.

#pragma mark - Public Methods Interface:

// Default initialization method.
-(id)init;

// Initialization methods that sets the interval start, end, and error tolerance.
-(id)initWithPtA:(NSNumber*)ptA WithPtB:(NSNumber*)ptB AndEpsilon:(NSNumber*)eps;

// Method that returns the approximation of the integral found using ASR.
-(NSNumber*)approximateUsingAdaptiveSimpsonsRule;

@end
