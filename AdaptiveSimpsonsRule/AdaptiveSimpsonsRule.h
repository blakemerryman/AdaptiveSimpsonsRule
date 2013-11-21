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
@property(nonatomic)NSNumber* ptA;      // The start of the interval to approximate using ASR.
@property(nonatomic)NSNumber* ptB;      // The end of the interval to approximate using ASR.
@property(nonatomic)NSNumber* eps;      // The error tolerance.

#pragma mark - Public Methods Interface:
// Default init method.
-(id)init;

// Custom init method to set start point, end point, and error tolerance.
-(id)initWithStart:(NSNumber*)ptA
               End:(NSNumber*)ptB
        AndEpsilon:(NSNumber*)eps;

// Method that returns the approximation of the integral found using ASR.
-(NSNumber*)evaluateAdaptiveSimpsonsMethod;

@end
