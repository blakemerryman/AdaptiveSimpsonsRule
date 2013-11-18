//
//  AdaptiveSimpsonsRule.h
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdaptiveSimpsonsRule : NSObject
@property(nonatomic)NSNumber* ptA;      // The start of the interval to approximate using ASR.
@property(nonatomic)NSNumber* ptB;      // The end of the interval to approximate using ASR.
@property(nonatomic)NSNumber* eps;      // The error tolerance.
@property(nonatomic)NSNumber* result;   // The result of the approximation using ASR.

-(id)init;                                      // Default init method.
-(id)initWithStart:(NSNumber*)ptA
               End:(NSNumber*)ptB
        AndEpsilon:(NSNumber*)eps;              // Custom initWith method.
-(id)recursiveAdaptiveSimpsonsRule;             // Recursive-adaptive logic method.
-(NSNumber*)theFunctionAtAPoint:(NSNumber*)pt;  // The function being approximated by ASR.
-(NSNumber*)simpsonsRule;                       // Simpson's Rule.
@end
