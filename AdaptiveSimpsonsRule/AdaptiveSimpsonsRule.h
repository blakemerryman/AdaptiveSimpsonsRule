//
//  AdaptiveSimpsonsRule.h
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdaptiveSimpsonsRule : NSObject
#pragma mark - Public Properties:
@property(nonatomic)NSNumber* pointA;      // The start of the interval to approximate using ASR.
@property(nonatomic)NSNumber* pointB;      // The end of the interval to approximate using ASR.
@property(nonatomic)NSNumber* error;       // The error tolerance.

#pragma mark - Public Methods Interface:
// Initialization methods. Sets the interval start, end, and error tolerance.
-(id)init;
-(id)initWithPtA:(NSNumber*)ptA WithPtB:(NSNumber*)ptB AndEpsilon:(NSNumber*)eps;

// Method that returns the approximation of the integral found using ASR.
-(NSNumber*)approximateUsingAdaptiveSimpsonsRule;

@end
